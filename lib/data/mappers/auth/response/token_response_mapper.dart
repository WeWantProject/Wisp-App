import 'package:wisp/data/models/auth/response/refresh_token_response_dto.dart';
import 'package:wisp/domain/entities/auth/refresh_token_entity.dart';

class TokenResponseMapper {
  static RefreshToken toEntity(RefreshTokenResponseDto dto) => RefreshToken(
        accessToken: dto.accessToken,
        refreshToken: dto.refreshToken,
      );

  static RefreshTokenResponseDto toDto(RefreshToken entity) =>
      RefreshTokenResponseDto(
        accessToken: entity.accessToken,
        refreshToken: entity.refreshToken,
      );
}
