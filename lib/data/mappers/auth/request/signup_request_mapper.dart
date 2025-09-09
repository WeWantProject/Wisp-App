import 'package:wisp/data/models/auth/request/signup_request_dto.dart';
import 'package:wisp/domain/entities/auth/signup_entity.dart';

class SignupRequestMapper {
  static SignUpEntity toEntity(SignUpRequestDto dto) => SignUpEntity(
        phoneNumber: dto.phoneNumber,
        password: dto.password,
        userName: dto.userName,
        displayName: dto.displayName,
      );
  static SignUpRequestDto toDto(SignUpEntity entity) => SignUpRequestDto(
        phoneNumber: entity.phoneNumber,
        password: entity.password,
        userName: entity.userName,
        displayName: entity.displayName,
      );
}
