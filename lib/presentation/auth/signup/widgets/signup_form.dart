import 'package:flutter/material.dart';
import 'package:wisp/presentation/auth/widgets/auth_button.dart';
import 'package:wisp/presentation/auth/widgets/form_textfield.dart';

class SignupForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController confromPhoneController;
  final TextEditingController passwordController;
  final TextEditingController conformPasswordController;

  final VoidCallback onSignup;

  final FocusNode nameFocusNode;
  final FocusNode phoneNumberFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode conformPasswordFocusNode;

  const SignupForm(
      {super.key,
      required this.nameController,
      required this.phoneController,
      required this.confromPhoneController,
      required this.passwordController,
      required this.conformPasswordController,
      required this.onSignup,
      required this.phoneNumberFocusNode,
      required this.passwordFocusNode,
      required this.conformPasswordFocusNode,
      required this.nameFocusNode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FormTextfield(
            hintText: '이름을 입력하세요.',
            labelText: '이름',
            controller: nameController,
            leadingIcon: Icons.person,
            focusNode: nameFocusNode,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 20),
          FormTextfield(
            hintText: '010-1234-5678',
            labelText: '전화번호',
            controller: phoneController,
            leadingIcon: Icons.phone,
            focusNode: phoneNumberFocusNode,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 20),
          FormTextfield(
            hintText: '비밀번호를 입력하세요.',
            labelText: '비밀번호',
            controller: passwordController,
            leadingIcon: Icons.lock,
            isPassword: true,
            focusNode: passwordFocusNode,
          ),
          const SizedBox(height: 20),
          FormTextfield(
            hintText: '비밀번호를 다시 입력하세요.',
            labelText: '비밀번호 확인',
            controller: conformPasswordController,
            leadingIcon: Icons.lock,
            isPassword: true,
            focusNode: conformPasswordFocusNode,
          ),
          const SizedBox(height: 40),
          AuthButton(onPressed: onSignup, text: '회원가입'),
        ],
      ),
    );
  }
}
