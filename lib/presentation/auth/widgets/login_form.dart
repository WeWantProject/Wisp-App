import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:wisp/presentation/auth/widgets/auth_button.dart';
import 'package:wisp/presentation/auth/widgets/form_textfield.dart';

class LoginForm extends HookWidget {
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;
  final FocusNode phoneNumberFocusNode;
  final FocusNode passwordFocusNode;

  const LoginForm(
      {required this.phoneController,
      required this.passwordController,
      required this.onLogin,
      required this.phoneNumberFocusNode,
      required this.passwordFocusNode,  
      super.key
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          const SizedBox(height: 40),
          AuthButton(onPressed: onLogin, text: '로그인'),
        ],
      ),
    );
  }
}
