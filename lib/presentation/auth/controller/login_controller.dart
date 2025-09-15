import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
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

      final String phoneNumber = _normalizePhoneNumber(phoneController.text);
      final password = passwordController.text.trim();
      print("${phoneNumber},${password}");

      if (!isValidPhoneNumber(phoneNumber)) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: '올바른 전화번호를 입력해주세요.',
        );
        print("휴대폰 번호 오류");
        return false;
      }

      if (!isValidPassword(password)) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: '비밀번호는 8자 이상이어야 합니다.',
        );
        print("비밀번호 오류");
        return false;
      }

      print("로그인중.");
      await signInUseCase.signIn(SignInEntity(
        phoneNumber: phoneNumber,
        password: password,
      ));

      print("로그인 완료");

      state = state.copyWith(
        isLoading: false,
        isLogin: true,
      );
      return true;
    } on DioException catch (e) {
      final Object? data = e.response?.data;
      final String serverMessage =
          data is Map<String, dynamic> && data['message'] is String
              ? data['message'] as String
              : '로그인에 실패했습니다. 다시 시도해주세요.';
      state = state.copyWith(
        isLoading: false,
        errorMessage: serverMessage,
      );
      return false;
    } catch (e) {
      debugPrint(e.toString());
      state = state.copyWith(
        isLoading: false,
        errorMessage: '로그인에 실패했습니다. 다시 시도해주세요.',
      );
      return false;
    }
  }

  bool isValidPhoneNumber(String phoneNumber) {
    return RegExp(r'^\d{11}$').hasMatch(phoneNumber);
  }

  bool isValidPassword(String password) {
    return password.length >= 8;
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String _normalizePhoneNumber(String input) {
    final String digitsOnly = input.replaceAll(RegExp(r'[^0-9]'), '');
    return digitsOnly.trim();
  }
}
