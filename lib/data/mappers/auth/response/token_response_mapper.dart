import 'package:wisp/data/models/auth/response/refresh_token_response_dto.dart';
import 'package:wisp/domain/entities/auth/token_entity.dart';

class TokenResponseMapper {
  static TokenEntity toEntity(RefreshTokenResponseDto dto) => TokenEntity(
        accessToken: dto.accessToken,
        refreshToken: dto.refreshToken,
      );

  static RefreshTokenResponseDto toDto(TokenEntity entity) =>
      RefreshTokenResponseDto(
        accessToken: entity.accessToken,
        refreshToken: entity.refreshToken,
      );
}
