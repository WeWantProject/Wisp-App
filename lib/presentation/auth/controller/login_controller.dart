
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisp/presentation/auth/state/login_state.dart';

final loginControllerProvider = StateNotifierProvider<LoginController, LoginState>(
  (ref) => LoginController(),
);

class LoginController extends StateNotifier<LoginState> {
  LoginController() : super(const LoginState());

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  void toggleLogin() {
    state = state.copyWith(isLogin: !state.isLogin);
  }

  bool isValidPhoneNumber(String phoneNumber) {
    return phoneNumber.length == 10; 
  }

  bool isValidPassword(String password) {
    return password.length >= 6;
  }
}