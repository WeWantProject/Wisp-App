import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_token_entity.freezed.dart';

@freezed
abstract class RefreshToken with _$RefreshToken {
  factory RefreshToken({
    required String accessToken,
    required String refreshToken,
  }) = _RefreshToken;
}
