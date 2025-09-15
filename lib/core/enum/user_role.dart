import 'package:freezed_annotation/freezed_annotation.dart';

enum UserRole {
  @JsonValue('ROLE_USER')
  user,
  @JsonValue('ROLE_ADMIN')
  admin,
}
