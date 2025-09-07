import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_entity.freezed.dart';

@freezed
abstract class SignUpEntity with _$SignUpEntity {
  factory SignUpEntity({
    required String userName,
    required String phoneNumber,
    required String password,
    required String displayName,
  }) = _SignUpEntity;
}
