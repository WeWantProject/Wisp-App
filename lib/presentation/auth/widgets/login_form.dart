import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisp/presentation/auth/controller/login_controller.dart';
import 'package:wisp/presentation/auth/state/login_state.dart';
import 'package:wisp/presentation/auth/widgets/auth_button.dart';
import 'package:wisp/presentation/auth/widgets/form_textfield.dart';

class LoginForm extends HookConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey key = GlobalKey<FormState>();

    final notifier = ref.watch(loginControllerProvider.notifier);

    final phoneController = useTextEditingController();
    final passwordController = useTextEditingController();

    final phoneFocus = useFocusNode();
    final passwordFocus = useFocusNode();

    useEffect(() {
      ref.listen<LoginState>(loginControllerProvider, (previous, next) {
        if (next.focusField == 'phone') {
          FocusScope.of(context).requestFocus(phoneFocus);
        } else if (next.focusField == 'password') {
          FocusScope.of(context).requestFocus(passwordFocus);
        }
      });

      return null;
    }, const []);

    void _showSnackBar(BuildContext context, String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    Future<void> login() async {
      if (!notifier.isValidPhoneNumber(phoneController.text.trim())) {
        _showSnackBar(context, "유효하지 않은 전화번호 입니다.");
        FocusScope.of(context).requestFocus(phoneFocus);
        return;
      }

      if (!notifier.isValidPassword(passwordController.text.trim())) {
        _showSnackBar(context, "유효하지 않은 비밀번호 입니다.");
        FocusScope.of(context).requestFocus(passwordFocus);
        return;
      }
      try {
        await notifier.login(
          phoneController.text.trim(),
          passwordController.text.trim(),
        );
      } catch (e) {
        _showSnackBar(context, "로그인 정보가 일치하지 않습니다.");
      }

      if (ref.read(loginControllerProvider).isLogin) {
        if (context.mounted) {
          context.go('/main');
        }
      }
    }

    return Form(
      key: key,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FormTextfield(
              hintText: '010-1234-5678',
              labelText: '전화번호',
              controller: phoneController,
              leadingIcon: Icons.phone,
              focusNode: phoneFocus,
              keyboardType: TextInputType.phone,
            ),
            const Gap(20),
            FormTextfield(
              hintText: '비밀번호를 입력하세요.',
              labelText: '비밀번호',
              controller: passwordController,
              leadingIcon: Icons.lock,
              isPassword: true,
              focusNode: passwordFocus,
            ),
            const Gap(40),
            AuthButton(
              onPressed: () {
                login();
              },
              text: '로그인',
            ),
          ],
        ),
      ),
    );
  }
}
