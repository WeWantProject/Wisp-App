import 'package:wisp/data/models/auth/response/signin_response_dto.dart';
import 'package:wisp/domain/entities/auth/token_entity.dart';

class SigninResponseMapper {
  static TokenEntity toEntity(SignInResponseDto dto) => TokenEntity(
        accessToken: dto.accessToken,
        refreshToken: dto.refreshToken,
        accessTokenExpiration: dto.accessTokenExpiration,
        refreshTokenExpiration: dto.refreshTokenExpiration,
        role: dto.role,
      );

  static SignInResponseDto toDto(TokenEntity entity) => SignInResponseDto(
        accessToken: entity.accessToken,
        refreshToken: entity.refreshToken,
        accessTokenExpiration: entity.accessTokenExpiration,
        refreshTokenExpiration: entity.refreshTokenExpiration,
        role: entity.role,
      );
}
