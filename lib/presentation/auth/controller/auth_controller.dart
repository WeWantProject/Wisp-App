import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisp/presentation/auth/state/auth_state.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) => AuthController(),
);

class AuthController extends StateNotifier<AuthState> {
  AuthController() : super(const AuthState());

  void toggleAuthMode(int index) {
    if (index == 1) {  
    state = state.copyWith(isLoginMode: [false, true]);  
  } else {  
    state = state.copyWith(isLoginMode: [true, false]);  
  }  
  }
}