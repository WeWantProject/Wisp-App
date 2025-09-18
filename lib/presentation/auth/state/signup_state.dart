import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_state.freezed.dart';

@freezed
abstract class SignupState with _$SignupState {
  factory SignupState({
    @Default(false) bool isPhoneNumber,
    @Default(false) bool isVerify,
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
  }) = _SignupState;
}
