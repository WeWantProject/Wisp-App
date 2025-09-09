import 'package:wisp/data/models/auth/request/signin_request_dto.dart';
import 'package:wisp/domain/entities/auth/signin_entity.dart';

extension SiginEntityMapper on SignInEntity {
  SignInEntity toEntity() {
    return SignInEntity(
      phoneNumber: phoneNumber,
      password: password,
    );
  }
}

extension SignInDtoMapper on SigninRequestDto {
  SigninRequestDto toDto() {
    return SigninRequestDto(
      phoneNumber: phoneNumber,
      password: password,
    );
  }
}
