import 'package:wisp/data/models/auth/request/signin_request_dto.dart';
import 'package:wisp/domain/entities/auth/signin_entity.dart';

class SigninRequestMapper {
  static SignInEntity toEntity(SigninRequestDto dto) => SignInEntity(
        phoneNumber: dto.phoneNumber,
        password: dto.password,
      );

  static SigninRequestDto toDto(SignInEntity entity) => SigninRequestDto(
        phoneNumber: entity.phoneNumber,
        password: entity.password,
      );
}
