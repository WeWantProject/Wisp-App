import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wisp/core/enum/user_role.dart';

part 'token_entity.freezed.dart';

@freezed
abstract class TokenEntity with _$TokenEntity {
  factory TokenEntity({
    required String accessToken,
    required String refreshToken,
    required DateTime accessTokenExpiration,
    required DateTime refreshTokenExpiration,
    required UserRole role,
  }) = _TokenEntity;
}
