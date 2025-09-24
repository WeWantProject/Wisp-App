import 'package:injectable/injectable.dart';
import 'package:wisp/domain/entities/auth/signup_entity.dart';
import 'package:wisp/domain/repositories/auth/auth_repository.dart';

@injectable
class SignUpUsecase {
  final AuthRepository authRepository;

  SignUpUsecase(this.authRepository);

  Future<void> signUp(SignUpEntity signUpentity) async {
    await authRepository.signUp(signUpentity);
  }

  Future<void> sendSms(String phoneNumber) async {
    await authRepository.sendSms(phoneNumber);
  }

  Future<void> verifySms(String code) async {
    await authRepository.verifyPhone(code);
  }
}
