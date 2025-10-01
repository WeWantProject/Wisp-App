import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisp/core/config/di/injection.dart';
import 'package:wisp/domain/usecases/auth/change_password_usecase.dart';
import 'package:wisp/domain/usecases/auth/logout_usecase.dart';
import 'package:wisp/domain/usecases/auth/refresh_token_usecase.dart';
import 'package:wisp/presentation/auth/state/auth_state.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    final logoutUsecase = getIt<LogoutUseCase>();
    final refreshTokenUseCase = getIt<RefreshTokenUseCase>();
    final changePasswordUseCase = getIt<ChangePasswordUseCase>();
    return AuthController(
      logoutUsecase,
      refreshTokenUseCase,
      changePasswordUseCase,
    );
  },
);

class AuthController extends StateNotifier<AuthState> {
  final _storage = const FlutterSecureStorage();
  final LogoutUseCase logoutUsecase;
  final RefreshTokenUseCase refreshTokenUseCase;
  final ChangePasswordUseCase changePasswordUseCase;

  AuthController(
    this.logoutUsecase,
    this.refreshTokenUseCase,
    this.changePasswordUseCase,
  ) : super(const AuthState());

  void toggleAuthMode(int index) {
    if (index == 1) {
      state = state.copyWith(isLoginMode: [false, true]);
    } else {
      state = state.copyWith(isLoginMode: [true, false]);
    }
  }

  Future<void> logout() async {
    final refreshToken = await _storage.read(key: 'refreshToken');
    if (refreshToken == null) {
      await _storage.deleteAll();
      return;
    }
    try {
      await logoutUsecase.logout(refreshToken);
    } finally {
      await _storage.deleteAll();
    }
  }

  Future<void> refreshToken() async {
    final refreshToken = await _storage.read(key: 'refreshToken');
    final newToken = await refreshTokenUseCase.refreshToken(refreshToken!);

    await _storage.write(key: 'accessToken', value: newToken.accessToken);
    await _storage.write(key: 'refreshToken', value: newToken.refreshToken);
    await _storage.write(
      key: 'accessTokenExpiration',
      value: newToken.accessTokenExpiration.toIso8601String(),
    );
    await _storage.write(
      key: 'refreshTokenExpiration',
      value: newToken.refreshTokenExpiration.toIso8601String(),
    );

    state = state.copyWith(isTokenExpired: false);
  }

  Future<void> setTokenExpired() async {
    state = state.copyWith(isTokenExpired: true);
  }
}
