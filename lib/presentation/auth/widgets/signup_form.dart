import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisp/domain/entities/auth/signup_entity.dart';
import 'package:wisp/presentation/auth/controller/signup_controller.dart';
import 'package:wisp/presentation/auth/widgets/auth_button.dart';
import 'package:wisp/presentation/auth/widgets/form_textfield.dart';

class SignUpForm extends HookConsumerWidget {
  SignUpForm({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(signUpControllerProvider.notifier);
    final state = ref.watch(signUpControllerProvider);

    // 컨트롤러들
    final nameController = useTextEditingController();
    final displayNameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final smsCodeController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    // 포커스 노드들
    final nameFocus = useFocusNode();
    final displayFocus = useFocusNode();
    final phoneFocus = useFocusNode();
    final smsFocus = useFocusNode();
    final passwordFocus = useFocusNode();
    final confirmPasswordFocus = useFocusNode();

    // SMS 타이머 상태
    final remainingTime = useState(0);
    final timerRef = useRef<Timer?>(null);
    final isSendingSms = useState(false);

    // SMS 전송 함수
    void handleSendSms() async {
      if (isSendingSms.value || remainingTime.value > 0) return;
      final phoneNumber = phoneController.text.trim();
      if (!notifier.isValidPhoneNumber(phoneNumber)) {
        _showSnackBar(context, '올바른 전화번호 형식이 아닙니다. (예: 01012345678)');
        return;
      }

      isSendingSms.value = true;
      try {
        await notifier.sendSms(phoneNumber);
        _startTimer(remainingTime, timerRef, () {
          smsCodeController.clear();
        });
      } finally {
        isSendingSms.value = false;
      }

      // SMS 전송 후 포커스 이동
      Future.delayed(const Duration(milliseconds: 300), () {
        if (smsFocus.canRequestFocus) {
          smsFocus.requestFocus();
        }
      });
    }

    // SMS 인증 함수
    void handleVerifySms() async {
      final smsCode = smsCodeController.text.trim();
      if (smsCode.isEmpty) {
        _showSnackBar(context, '인증번호를 입력해주세요.');
        return;
      }
      try {
        await notifier.verify(smsCode);
        timerRef.value?.cancel();
        Focus.of(context).unfocus();
      } catch (e) {
        _showSnackBar(context, e.toString());
      }
    }

    // 회원가입 함수
    void handleSignUp() {
      if (!_formKey.currentState!.validate()) return;

      if (!state.isPhoneNumber) {
        _showSnackBar(context, '휴대폰 인증을 완료해주세요.');
        return;
      }

      if (!state.isVerify) {
        _showSnackBar(context, 'SMS 인증을 완료해주세요.');
        return;
      }

      notifier.signUp(
        SignUpEntity(
          username: nameController.text.trim(),
          phoneNumber: phoneController.text.trim(),
          password: passwordController.text.trim(),
          displayName: displayNameController.text.trim(),
        ),
      );

      context.go('/auth');
    }

    // 컴포넌트 정리
    useEffect(() {
      return () {
        timerRef.value?.cancel();
      };
    }, []);

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // 이름 입력
            _buildNameField(nameController, nameFocus),
            const Gap(10),

            // 닉네임 입력
            _buildDisplayNameField(displayNameController, displayFocus),
            const Gap(10),

            // 전화번호 입력 및 SMS 전송
            _PhoneNumberSection(
              controller: phoneController,
              focusNode: phoneFocus,
              isEnabled:
                  !isSendingSms.value &&
                  (!state.isPhoneNumber || remainingTime.value == 0),
              remainingTime: remainingTime.value,
              onSendSms: handleSendSms,
              validator: _validatePhoneNumber,
            ),

            // SMS 인증 섹션
            if (state.isPhoneNumber) ...[
              const Gap(15),
              _SmsVerificationSection(
                controller: smsCodeController,
                focusNode: smsFocus,
                remainingTime: remainingTime.value,
                isVerified: state.isVerify,
                isLoading: state.isLoading,
                onVerify: handleVerifySms,
              ),
            ],

            // 시간 만료 알림
            if (state.isPhoneNumber &&
                remainingTime.value == 0 &&
                !state.isVerify) ...[
              const Gap(10),
              _buildTimeExpiredWarning(),
            ],

            const Gap(20),

            // 비밀번호 입력
            _buildPasswordField(passwordController, passwordFocus, notifier),
            const Gap(10),

            // 비밀번호 확인
            _buildConfirmPasswordField(
              confirmPasswordController,
              confirmPasswordFocus,
              passwordController,
              notifier,
            ),
            const Gap(20),

            AuthButton(
              onPressed: state.isLoading ? null : handleSignUp,
              text: state.isLoading ? '처리중...' : '회원가입',
            ),
          ],
        ),
      ),
    );
  }

  // 이름 필드 빌더
  Widget _buildNameField(TextEditingController controller, FocusNode focus) {
    return FormTextfield(
      hintText: '실명을 입력하세요.',
      labelText: '이름',
      controller: controller,
      leadingIcon: Icons.person,
      focusNode: focus,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '이름을 입력해주세요.';
        }
        return null;
      },
    );
  }

  // 닉네임 필드 빌더
  Widget _buildDisplayNameField(
    TextEditingController controller,
    FocusNode focus,
  ) {
    return FormTextfield(
      hintText: '닉네임을 입력하세요.',
      labelText: '닉네임',
      controller: controller,
      leadingIcon: Icons.person,
      focusNode: focus,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '닉네임을 입력해주세요.';
        }
        return null;
      },
    );
  }

  // 비밀번호 필드 빌더
  Widget _buildPasswordField(
    TextEditingController controller,
    FocusNode focus,
    SignupController notifier,
  ) {
    return FormTextfield(
      hintText: '비밀번호를 입력하세요.',
      labelText: '비밀번호',
      controller: controller,
      leadingIcon: Icons.lock,
      isPassword: true,
      focusNode: focus,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '비밀번호를 입력해주세요.';
        }
        if (!notifier.isValidPassword(value)) {
          return '비밀번호는 최소 8자리 이상이어야 합니다.';
        }
        return null;
      },
    );
  }

  // 비밀번호 확인 필드 빌더
  Widget _buildConfirmPasswordField(
    TextEditingController confirmController,
    FocusNode focus,
    TextEditingController passwordController,
    SignupController notifier,
  ) {
    return FormTextfield(
      hintText: '비밀번호를 다시 입력하세요.',
      labelText: '비밀번호 확인',
      controller: confirmController,
      leadingIcon: Icons.lock,
      isPassword: true,
      focusNode: focus,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '비밀번호 확인을 입력해주세요.';
        }
        if (!notifier.isPasswordMatch(passwordController.text, value)) {
          return '비밀번호가 일치하지 않습니다.';
        }
        return null;
      },
    );
  }

  // 시간 만료 경고 빌더
  Widget _buildTimeExpiredWarning() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.withOpacity(0.5)),
      ),
      child: const Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 20),
          Gap(8),
          Expanded(
            child: Text(
              '인증 시간이 만료되었습니다. SMS를 다시 전송해주세요.',
              style: TextStyle(color: Colors.orange, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  // 전화번호 검증
  String? _validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '전화번호를 입력해주세요.';
    }
    if (!RegExp(r'^010\d{8}$').hasMatch(value.trim())) {
      return '올바른 전화번호 형식이 아닙니다. (예: 01012345678)';
    }
    return null;
  }

  // 스낵바 표시
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // 타이머 시작
  void _startTimer(
    ValueNotifier<int> remainingTime,
    ObjectRef<Timer?> timerRef,
    VoidCallback onExpired,
  ) {
    remainingTime.value = 300; // 5분
    timerRef.value?.cancel();

    timerRef.value = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        timer.cancel();
        onExpired();
      }
    });
  }
}

class _PhoneNumberSection extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isEnabled;
  final int remainingTime;
  final VoidCallback onSendSms;
  final String? Function(String?)? validator;

  const _PhoneNumberSection({
    required this.controller,
    required this.focusNode,
    required this.isEnabled,
    required this.remainingTime,
    required this.onSendSms,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: FormTextfield(
            hintText: '-를 제외하고 입력해주세요.',
            labelText: '전화번호',
            controller: controller,
            leadingIcon: Icons.phone,
            focusNode: focusNode,
            keyboardType: TextInputType.phone,
            validator: validator,
            isEnabled: isEnabled,
          ),
        ),
        const Gap(8),
        Padding(
          padding: const EdgeInsets.only(top: 35),
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isEnabled ? Colors.blue : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              onPressed: isEnabled ? onSendSms : null,
              child: Text(
                _getButtonText(),
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getButtonText() {
    if (isEnabled) return "SMS 전송";
    if (remainingTime > 0) return "전송완료";
    return "재전송";
  }
}

// SMS 인증 섹션
class _SmsVerificationSection extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final int remainingTime;
  final bool isVerified;
  final bool isLoading;
  final VoidCallback onVerify;

  const _SmsVerificationSection({
    required this.controller,
    required this.focusNode,
    required this.remainingTime,
    required this.isVerified,
    required this.isLoading,
    required this.onVerify,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormTextfield(
          hintText: "인증 번호를 입력하세요.",
          labelText: "인증번호",
          controller: controller,
          leadingIcon: Icons.check,
          focusNode: focusNode,
          keyboardType: TextInputType.number,
          isEnabled: !isVerified && remainingTime > 0,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return '인증번호를 입력해주세요.';
            }
            return null;
          },
        ),
        if (remainingTime > 0) ...[const Gap(8), _buildTimerDisplay()],
        const Gap(15),
        _buildVerifyButton(),
      ],
    );
  }

  Widget _buildTimerDisplay() {
    final minutes = remainingTime ~/ 60;
    final seconds = remainingTime % 60;
    final timeString =
        "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";

    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Text(
        '남은 시간: $timeString',
        style: TextStyle(
          color: remainingTime <= 60 ? Colors.red : Colors.orange,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildVerifyButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: (isLoading || isVerified || remainingTime == 0)
            ? null
            : onVerify,
        style: ElevatedButton.styleFrom(
          backgroundColor: isVerified
              ? Colors.green
              : (remainingTime == 0 ? Colors.grey : Colors.blue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isVerified) ...[
                    const Icon(Icons.check, color: Colors.white, size: 18),
                    const Gap(8),
                  ],
                  Text(
                    _getButtonText(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  String _getButtonText() {
    if (isVerified) return '인증완료';
    if (remainingTime == 0) return '시간만료';
    return '인증하기';
  }
}
