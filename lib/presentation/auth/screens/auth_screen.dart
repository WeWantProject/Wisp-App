import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisp/core/config/constans/base_scoffold.dart';
import 'package:wisp/core/config/constans/colors.dart';
import 'package:wisp/presentation/auth/controller/auth_controller.dart';
import 'package:wisp/presentation/auth/login/controller/login_controller.dart';
import 'package:wisp/presentation/auth/login/widgets/login_form.dart';
import 'package:wisp/presentation/auth/signup/widgets/signup_form.dart';

class AuthScreen extends HookConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authControllerProvider.notifier);
    final authState = ref.watch(authControllerProvider);


    final notifier = ref.watch(loginControllerProvider.notifier);

    final phoneNumberFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();

    return BaseScoffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoSection(),
            const SizedBox(height: 30),
            ToggleAuthButton(
              isSelected: authState.isLogin,
              onPressed: authNotifier.toggleAuthMode,
            ),
            const SizedBox(height: 20),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 0.95, end: 1.0)
                        .animate(animation),
                    child: child,
                  ),
                );
              },
              child: authState.isLogin[0]
                  ? LoginForm(
                      phoneNumberFocusNode: phoneNumberFocusNode,
                      passwordFocusNode: passwordFocusNode,
                      phoneController: notifier.phoneCoontroller,
                      passwordController: notifier.passwordController, 
                      onLogin: () {
                        if (notifier.isValidPhoneNumber(notifier.phoneCoontroller.text) &&
                            notifier.isValidPassword(notifier.passwordController.text)) {
                        } else {
                          if(notifier.phoneCoontroller.text.isEmpty) {
                            phoneNumberFocusNode.requestFocus();
                          } else if (!notifier.isValidPhoneNumber(notifier.phoneCoontroller.text)) {
                            phoneNumberFocusNode.requestFocus();
                          } else if (notifier.passwordController.text.isEmpty) {
                            passwordFocusNode.requestFocus();
                          } else if (!notifier.isValidPassword(notifier.passwordController.text)) {
                            passwordFocusNode.requestFocus();
                          }
                        }
                      },
                    )
                  : SignupForm(
                    nameController: TextEditingController(), 
                    phoneController: TextEditingController(), 
                    confromPhoneController: TextEditingController(),
                    passwordController: TextEditingController(),
                    conformPasswordController: TextEditingController(),
                    onSignup: () {  },
                    phoneNumberFocusNode: FocusNode(),
                    passwordFocusNode: FocusNode(),
                    conformPasswordFocusNode: FocusNode(),
                    nameFocusNode: FocusNode()
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class LogoSection extends StatelessWidget {
  const LogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/images/wisp_logo.svg',
          width: 100,
          height: 100,
        ),
        const SizedBox(height: 20),
        const Text(
          'Wisp',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          '가벼운 소통, 깊은 연결',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class ToggleAuthButton extends StatelessWidget {
  final List<bool> isSelected;
  final void Function(int) onPressed;

  const ToggleAuthButton({
    super.key,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 355,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ToggleButtons(
        color: Colors.blueGrey[300],
        isSelected: isSelected,
        onPressed: onPressed,
        selectedColor: Colors.white,
        fillColor: WispColors.grey,
        borderRadius: BorderRadius.circular(8),
        constraints: const BoxConstraints(
          minHeight: 50,
          minWidth: 175,
        ),
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text('로그인'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text('회원가입'),
          ),
        ],
      ),
    );
  }
}
