import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisp/core/config/di/injection.dart';
import 'package:wisp/domain/usecases/auth/logout_usecase.dart';
import 'package:wisp/presentation/auth/state/auth_state.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    final logoutUsecase = getIt<LogoutUsecase>();
    return AuthController(logoutUsecase);
  },
);

class AuthController extends StateNotifier<AuthState> {
  final _storage = const FlutterSecureStorage();
  final LogoutUsecase logoutUsecase;

  AuthController(this.logoutUsecase) : super(const AuthState());

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
}
