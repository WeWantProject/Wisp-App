import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wisp/core/enum/user_role.dart';

part 'auth_token_response_dto.g.dart';
part 'auth_token_response_dto.freezed.dart';

@freezed
abstract class AuthTokenResponseDto with _$AuthTokenResponseDto {
  const factory AuthTokenResponseDto({
    required String accessToken,
    required String refreshToken,
    required DateTime accessTokenExpiration,
    required DateTime refreshTokenExpiration,
    required UserRole role,
  }) = _AuthTokenResponseDto;

  factory AuthTokenResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenResponseDtoFromJson(json);
}
