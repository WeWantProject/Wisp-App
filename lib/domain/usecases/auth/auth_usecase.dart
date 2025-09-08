import 'package:wisp/domain/entities/auth/signup_entity.dart';
import 'package:wisp/domain/repositories/auth/auth_repository.dart';

class AuthUsecase {
  final AuthRepository authRepository;

  AuthUsecase(this.authRepository);

  Future<void> signUp(SignUpEntity signUpEntity) async {
    return await authRepository.signUp(signUpEntity);
  }

  Future<void> sendSms(String phoneNumber) async {
    return await authRepository.sendSms(phoneNumber);
  }

  Future<void> verifySms(String code) async {
    return await authRepository.verifySms(code);
  }
}
