import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisp/core/config/di/injection.dart';
import 'package:wisp/domain/entities/auth/token_entity.dart';
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
    if (refreshToken == null) return;
    await logoutUsecase.logout(refreshToken);
    _storage.deleteAll();
  }

  Future<TokenEntity> refreshToken() async {
    final refreshToken = await _storage.read(key: 'refreshToken');
    final newToken = await refreshTokenUseCase.refreshToken(refreshToken!);
    return newToken;
  }
}
