import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisp/presentation/auth/state/auth_state.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(),
);

class AuthController extends StateNotifier<AuthState> {
  AuthController() : super(const AuthState());

  void toggleAuthMode(int index) {
    index == 1 ? 
      state = state.copyWith(isLogin: [false, true]) : 
      state = state.copyWith(isLogin: [true, false]);
  }
}