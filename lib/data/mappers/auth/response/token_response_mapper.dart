import 'package:wisp/data/models/auth/response/refresh_token_response_dto.dart';
import 'package:wisp/domain/entities/auth/token_entity.dart';

extension TokenEntityMapper on TokenEntity {
  TokenEntity toEntity() {
    return TokenEntity(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}

extension TokenDtoMapper on RefreshTokenResponseDto {
  RefreshTokenResponseDto toDto() {
    return RefreshTokenResponseDto(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
