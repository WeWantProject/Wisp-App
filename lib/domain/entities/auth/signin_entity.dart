import 'package:freezed_annotation/freezed_annotation.dart';

part 'signin_entity.freezed.dart';

@freezed
abstract class SignInEntity with _$SignInEntity {
  const factory SignInEntity({
    required String phoneNumber,
    required String password,
  }) = _SignInEntity;
}
