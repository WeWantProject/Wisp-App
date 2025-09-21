import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisp/core/config/constants/colors.dart';
import 'package:wisp/domain/entities/auth/signup_entity.dart';
import 'package:wisp/presentation/auth/controller/signup_controller.dart';
import 'package:wisp/presentation/auth/widgets/auth_button.dart';
import 'package:wisp/presentation/auth/widgets/form_textfield.dart';

class SignupForm extends HookConsumerWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(signUpControllerProvider.notifier);
    final state = ref.watch(signUpControllerProvider);

    final size = MediaQuery.of(context).size;

    final TextEditingController nameController = useTextEditingController();
    final TextEditingController phoneController = useTextEditingController();
    final TextEditingController conformPhoneController =
        useTextEditingController();
    final TextEditingController passwordController = useTextEditingController();
    final TextEditingController conformPasswordController =
        useTextEditingController();
    final TextEditingController displaynameController =
        useTextEditingController();

    final FocusNode nameFocusNode = useFocusNode();
    final FocusNode phoneNumberFocusNode = useFocusNode();
    final FocusNode passwordFocusNode = useFocusNode();
    final FocusNode conformPasswordFocusNode = useFocusNode();
    final FocusNode smsCodeFocusNode = useFocusNode();
    final FocusNode displaynameFocusNode = useFocusNode();

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: size.height),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.03,
            horizontal: size.width * 0.04,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.08,
                child: FormTextfield(
                  hintText: '실명을 입력하세요.',
                  labelText: '이름',
                  controller: nameController,
                  leadingIcon: Icons.person,
                  focusNode: nameFocusNode,
                  keyboardType: TextInputType.name,
                ),
              ),
              FormTextfield(
                hintText: '닉네임을 입력하세요.',
                labelText: '닉네임',
                controller: displaynameController,
                leadingIcon: Icons.person,
                focusNode: displaynameFocusNode,
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: size.height * 0.02),
              _PhoneNumberField(
                controller: phoneController,
                focusNode: phoneNumberFocusNode,
                isEnabled: !state.isPhoneNumber,
                sendSms: () async {
                  if (!notifier.isValidPhoneNumber(phoneController.text.trim()))
                    return;
                  await notifier.sendSms(phoneController.text.trim());
                  FocusScope.of(context).requestFocus(smsCodeFocusNode);
                },
              ),
              Offstage(
                offstage: !state.isPhoneNumber,
                child: SizedBox(
                  height: size.height * 0.08,
                  child: FormTextfield(
                    hintText: "인증 번호를 입력하세요.",
                    labelText: "인증번호",
                    controller: conformPhoneController,
                    leadingIcon: Icons.check,
                    focusNode: smsCodeFocusNode,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              SizedBox(
                height: size.height * 0.08,
                child: FormTextfield(
                  hintText: '비밀번호를 입력하세요.',
                  labelText: '비밀번호',
                  controller: passwordController,
                  leadingIcon: Icons.lock,
                  isPassword: true,
                  focusNode: passwordFocusNode,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              SizedBox(
                height: size.height * 0.08,
                child: FormTextfield(
                  hintText: '비밀번호를 다시 입력하세요.',
                  labelText: '비밀번호 확인',
                  controller: conformPasswordController,
                  leadingIcon: Icons.lock,
                  isPassword: true,
                  focusNode: conformPasswordFocusNode,
                ),
              ),
              SizedBox(height: size.height * 0.05),
              AuthButton(
                onPressed: () {
                  if (!state.isVerify && !state.isPhoneNumber) return;
                  if (nameController.text.trim().isEmpty) {
                    FocusScope.of(context).requestFocus(nameFocusNode);
                    return;
                  }
                  if (displaynameController.text.trim().isEmpty) {
                    FocusScope.of(context).requestFocus(displaynameFocusNode);
                    return;
                  }
                  notifier.signUp(
                    SignUpEntity(
                      userName: nameController.text.trim(),
                      phoneNumber: phoneController.text.trim(),
                      password: passwordController.text.trim(),
                      displayName: displaynameController.text.trim(),
                    ),
                  );
                },
                text: '회원가입',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isEnabled;
  final VoidCallback sendSms;

  const _PhoneNumberField({
    required this.controller,
    required this.focusNode,
    required this.isEnabled,
    required this.sendSms,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: FormTextfield(
            hintText: '010-1234-5678',
            labelText: '전화번호',
            controller: controller,
            leadingIcon: Icons.phone,
            focusNode: focusNode,
            keyboardType: TextInputType.phone,
          ),
        ),
        const Gap(8),
        Column(
          children: [
            const SizedBox(height: 30),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isEnabled
                      ? Colors.amber
                      : WispColors.deepBlue3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                onPressed: isEnabled ? sendSms : null,
                child: const Text(
                  "휴대폰 인증",
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
