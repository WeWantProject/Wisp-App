import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default([true, false]) List<bool> isLoginMode,
    @Default(false) bool isTokenExpired,
  }) = _AuthState;
}
