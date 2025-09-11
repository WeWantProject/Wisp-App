import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisp/core/config/di/injection.dart';
import 'package:wisp/domain/entities/auth/signin_entity.dart';
import 'package:wisp/domain/usecases/auth/signin_usecase.dart';
import 'package:wisp/presentation/auth/state/login_state.dart';

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
  final signInuseCase = getIt<SignInUseCase>();
  return LoginController(signInuseCase);
});

class LoginController extends StateNotifier<LoginState> {
  final SignInUseCase signInUseCase;

  LoginController(this.signInUseCase) : super(const LoginState());

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  Future<bool> login() async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: '');

      final phoneNumber = phoneController.text.trim();
      final password = passwordController.text.trim();

      if (!isValidPhoneNumber(phoneNumber)) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: '올바른 전화번호를 입력해주세요.',
        );
        return false;
      }

      if (!isValidPassword(password)) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: '비밀번호는 11자 이상이어야 합니다.',
        );
        return false;
      }

      await signInUseCase.signIn(SignInEntity(
        phoneNumber: phoneNumber,
        password: password,
      ));

      state = state.copyWith(
        isLoading: false,
        isLogin: true,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '로그인에 실패했습니다. 다시 시도해주세요.',
      );
      return false;
    }
  }

  bool isValidPhoneNumber(String phoneNumber) {
    return phoneNumber.length == 11;
  }

  bool isValidPassword(String password) {
    return password.length >= 11;
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
