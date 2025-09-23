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

    final nameController = useTextEditingController();
    final displayNameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final smsCodeController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    final nameFocus = useFocusNode();
    final displayFocus = useFocusNode();
    final phoneFocus = useFocusNode();
    final smsFocus = useFocusNode();
    final passwordFocus = useFocusNode();
    final confirmPasswordFocus = useFocusNode();

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            FormTextfield(
              hintText: '실명을 입력하세요.',
              labelText: '이름',
              controller: nameController,
              leadingIcon: Icons.person,
              focusNode: nameFocus,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '이름을 입력해주세요.';
                }
                return null;
              },
            ),
            const Gap(10),
            FormTextfield(
              hintText: '닉네임을 입력하세요.',
              labelText: '닉네임',
              controller: displayNameController,
              leadingIcon: Icons.person,
              focusNode: displayFocus,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '닉네임을 입력해주세요.';
                }
                return null;
              },
            ),
            const Gap(10),
            _PhoneNumberField(
              controller: phoneController,
              focusNode: phoneFocus,
              isEnabled: !state.isPhoneNumber,
              sendSms: () {
                final phoneNumber = phoneController.text.trim();
                if (!notifier.isValidPhoneNumber(phoneNumber)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('올바른 전화번호 형식이 아닙니다. (예: 01012345678)'),
                    ),
                  );
                  return;
                }
                notifier.sendSms(phoneNumber);
              },
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '전화번호를 입력해주세요.';
                }
                if (!notifier.isValidPhoneNumber(value.trim())) {
                  return '올바른 전화번호 형식이 아닙니다. (예: 01012345678)';
                }
                return null;
              },
            ),
            if (state.isPhoneNumber) ...[
              const Gap(10),
              FormTextfield(
                hintText: "인증 번호를 입력하세요.",
                labelText: "인증번호",
                controller: smsCodeController,
                leadingIcon: Icons.check,
                focusNode: smsFocus,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '인증번호를 입력해주세요.';
                  }
                  return null;
                },
              ),
              const Gap(10),
              ElevatedButton(
                onPressed: state.isLoading
                    ? null
                    : () {
                        final smsCode = smsCodeController.text.trim();
                        if (smsCode.isNotEmpty) {
                          notifier.verify(smsCode);
                          // 인증 결과는 state 변화로 확인
                        }
                      },
                child: state.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(state.isVerify ? '인증완료' : '인증하기'),
              ),
            ],
            const Gap(10),
            FormTextfield(
              hintText: '비밀번호를 입력하세요.',
              labelText: '비밀번호',
              controller: passwordController,
              leadingIcon: Icons.lock,
              isPassword: true,
              focusNode: passwordFocus,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '비밀번호를 입력해주세요.';
                }
                if (!notifier.isValidPassword(value)) {
                  return '비밀번호는 최소 8자리 이상이어야 합니다.';
                }
                return null;
              },
            ),
            const Gap(10),
            FormTextfield(
              hintText: '비밀번호를 다시 입력하세요.',
              labelText: '비밀번호 확인',
              controller: confirmPasswordController,
              leadingIcon: Icons.lock,
              isPassword: true,
              focusNode: confirmPasswordFocus,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '비밀번호 확인을 입력해주세요.';
                }
                if (!notifier.isPasswordMatch(passwordController.text, value)) {
                  return '비밀번호가 일치하지 않습니다.';
                }
                return null;
              },
            ),
            const Gap(20),
            AuthButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;

                if (!state.isPhoneNumber) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('휴대폰 인증을 완료해주세요.')),
                  );
                  return;
                }

                if (!state.isVerify) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('SMS 인증을 완료해주세요.')),
                  );
                  return;
                }
                print("이름: ${nameController.text.trim()}");
                print("휴대폰: ${phoneController.text.trim()}");
                print("비밀번호: ${passwordController.text.trim()}");
                print("닉네임: ${displayNameController.text.trim()}");
                notifier.signUp(
                  SignUpEntity(
                    username: nameController.text.trim(),
                    phoneNumber: phoneController.text.trim(),
                    password: passwordController.text.trim(),
                    displayName: displayNameController.text.trim(),
                  ),
                );
                context.go('/auth');
              },
              text: state.isLoading ? '처리중...' : '회원가입',
            ),
          ],
        ),
      ),
    );
  }
}

class _PhoneNumberField extends HookWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isEnabled;
  final VoidCallback sendSms;
  final String? Function(String?)? validator;

  const _PhoneNumberField({
    required this.controller,
    required this.focusNode,
    required this.isEnabled,
    required this.sendSms,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final remainingTime = useState(0);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: FormTextfield(
            hintText: '01012345678',
            labelText: '전화번호',
            controller: controller,
            leadingIcon: Icons.phone,
            focusNode: focusNode,
            keyboardType: TextInputType.phone,
            validator: validator,
          ),
        ),
        const Gap(8),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isEnabled ? Colors.amber : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              onPressed: isEnabled ? sendSms : null,
              child: Text(
                isEnabled
                    ? "SMS 전송"
                    : (remainingTime.value > 0 ? "전송완료" : "재전송"),
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
