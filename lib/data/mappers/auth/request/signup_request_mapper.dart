import 'package:wisp/data/models/auth/request/signup_request_dto.dart';
import 'package:wisp/domain/entities/auth/signup_entity.dart';

extension SignUpEntityMapper on SignUpEntity {
  SignUpEntity toEntity() {
    return SignUpEntity(
      phoneNumber: phoneNumber,
      password: password,
      userName: userName,
      displayName: displayName,
    );
  }
}

extension SignupDtoMapper on SignUpRequestDto {
  SignUpRequestDto toDto() {
    return SignUpRequestDto(
      phoneNumber: phoneNumber,
      password: password,
      userName: userName,
      displayName: displayName,
    );
  }
}
