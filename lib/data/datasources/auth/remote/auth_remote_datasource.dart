import 'package:injectable/injectable.dart';
import 'package:wisp/data/datasources/auth/remote/auth_api.dart';
import 'package:wisp/data/models/auth/request/signin_request_dto.dart';
import 'package:wisp/data/models/auth/request/signup_request_dto.dart';
import 'package:wisp/data/models/auth/response/auth_token_response_dto.dart';

abstract class AuthRemoteDataSource {
  Future<void> sendSms(String phoneNumber);
  Future<void> verifyPhone(String code);
  Future<void> signUp(SignUpRequestDto dto);
  Future<AuthTokenResponseDto> signIn(SigninRequestDto dto);
  Future<void> changePassword(String phoneNumber, String newPassword);
  Future<AuthTokenResponseDto> refreshToken(String refreshToken);
  Future<void> logout(String refreshToken);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApi api;

  AuthRemoteDataSourceImpl(this.api);

  @override
  Future<void> sendSms(String phoneNumber) async {
    await api.sendSms({"phoneNumber": phoneNumber});
  }

  @override
  Future<void> verifyPhone(String code) async {
    await api.verifyPhone({"code": code});
  }

  @override
  Future<void> signUp(SignUpRequestDto dto) => api.signUp(dto);

  @override
  Future<AuthTokenResponseDto> signIn(SigninRequestDto dto) => api.signIn(dto);

  @override
  Future<void> changePassword(String phoneNumber, String newPassword) async {
    await api.changePassword({
      "phoneNumber": phoneNumber,
      "newPassword": newPassword,
    });
  }

  @override
  Future<AuthTokenResponseDto> refreshToken(String refreshToken) =>
      api.refreshToken({"refreshToken": refreshToken});

  @override
  Future<void> logout(String refreshToken) =>
      api.logout({"refreshToken": refreshToken});
}
