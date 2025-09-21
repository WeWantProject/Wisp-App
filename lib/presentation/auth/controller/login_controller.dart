import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisp/core/config/di/injection.dart';
import 'package:wisp/domain/entities/auth/signin_entity.dart';
import 'package:wisp/domain/usecases/auth/signin_usecase.dart';
import 'package:wisp/presentation/auth/state/login_state.dart';

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
      final signInuseCase = getIt<SigninUsecase>();
      return LoginController(signInuseCase);
    });

class LoginController extends StateNotifier<LoginState> {
  final SigninUsecase signInUseCase;
  final _secureStorage = const FlutterSecureStorage();

  LoginController(this.signInUseCase) : super(const LoginState());

  Future<bool> login(String phoneNumber, String password) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: '');
      if (!isValidPhoneNumber(phoneNumber)) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: '올바른 전화번호를 입력해주세요.',
          focusField: "phone",
        );
        return false;
      }

      if (!isValidPassword(password)) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: '비밀번호는 8자 이상이어야 합니다.',
          focusField: "password",
        );
        return false;
      }

      final response = await signInUseCase.signIn(
        SignInEntity(phoneNumber: phoneNumber, password: password),
      );

      await _secureStorage.write(
        key: 'accessToken',
        value: response.accessToken,
      );
      await _secureStorage.write(
        key: 'refreshToken',
        value: response.refreshToken,
      );
      await _secureStorage.write(
        key: 'accessTokenExpiration',
        value: response.accessTokenExpiration.toIso8601String(),
      );
      await _secureStorage.write(
        key: 'refreshTokenExpiration',
        value: response.refreshTokenExpiration.toIso8601String(),
      );
      await _secureStorage.write(key: 'userRole', value: response.role.name);

      state = state.copyWith(isLoading: false, isLogin: true, focusField: null);
      return true;
    } on DioException catch (e) {
      final Object? data = e.response?.data;
      final String serverMessage =
          data is Map<String, dynamic> && data['message'] is String
          ? data['message'] as String
          : '로그인에 실패했습니다. 다시 시도해주세요.';
      state = state.copyWith(isLoading: false, errorMessage: serverMessage);
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
}
