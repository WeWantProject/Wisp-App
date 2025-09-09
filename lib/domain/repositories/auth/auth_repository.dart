import 'package:wisp/domain/entities/auth/signin_entity.dart';
import 'package:wisp/domain/entities/auth/signup_entity.dart';
import 'package:wisp/domain/entities/auth/token_entity.dart';

abstract class AuthRepository {
  Future<void> signUp(SignUpEntity signUpEntity);

  Future<void> sendSms(String phoneNumber);

  Future<void> verifyPhone(String code);

  Future<void> changePassword(String phoneNumber, String newPassword);

  Future<void> signIn(SignInEntity signinEntity);

  Future<TokenEntity> refreshToken(String refreshToken);
}
