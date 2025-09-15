import 'package:injectable/injectable.dart';
import 'package:wisp/data/datasources/auth/remote/auth_remote_datasource.dart';
import 'package:wisp/data/mappers/auth/request/signin_request_mapper.dart';
import 'package:wisp/data/mappers/auth/request/signup_request_mapper.dart';
import 'package:wisp/data/mappers/auth/response/signin_response_mapper.dart';
import 'package:wisp/data/mappers/auth/response/token_response_mapper.dart';
import 'package:wisp/domain/entities/auth/signin_entity.dart';
import 'package:wisp/domain/entities/auth/signup_entity.dart';
import 'package:wisp/domain/entities/auth/refresh_token_entity.dart';
import 'package:wisp/domain/entities/auth/token_entity.dart';
import 'package:wisp/domain/repositories/auth/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> changePassword(String phoneNumber, String newPassword) async {
    await remoteDataSource.changePassword(phoneNumber, newPassword);
  }

  @override
  Future<RefreshToken> refreshToken(String refreshToken) async {
    final response = await remoteDataSource.refreshToken(refreshToken);
    return TokenResponseMapper.toEntity(response);
  }

  @override
  Future<void> sendSms(String phoneNumber) {
    return remoteDataSource.sendSms(phoneNumber);
  }

  @override
  Future<TokenEntity> signIn(SignInEntity signinEntity) async {
    final dto = SigninRequestMapper.toDto(signinEntity);
    final response = await remoteDataSource.signIn(dto);
    return SigninResponseMapper.toEntity(response);
  }

  @override
  Future<void> signUp(SignUpEntity signUpEntity) {
    final dto = SignupRequestMapper.toDto(signUpEntity);
    return remoteDataSource.signUp(dto);
  }

  @override
  Future<void> verifyPhone(String code) async {
    return remoteDataSource.verifyPhone(code);
  }
}
