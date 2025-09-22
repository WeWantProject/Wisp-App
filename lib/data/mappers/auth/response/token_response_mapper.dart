import 'package:wisp/data/models/auth/response/auth_token_response_dto.dart';
import 'package:wisp/domain/entities/auth/token_entity.dart';

class TokenResponseMapper {
  static TokenEntity toEntity(AuthTokenResponseDto dto) => TokenEntity(
    accessToken: dto.accessToken,
    refreshToken: dto.refreshToken,
    accessTokenExpiration: dto.accessTokenExpiration,
    refreshTokenExpiration: dto.refreshTokenExpiration,
    role: dto.role,
  );

  static AuthTokenResponseDto toDto(TokenEntity entity) => AuthTokenResponseDto(
    accessToken: entity.accessToken,
    refreshToken: entity.refreshToken,
    accessTokenExpiration: entity.accessTokenExpiration,
    refreshTokenExpiration: entity.refreshTokenExpiration,
    role: entity.role,
  );
}
