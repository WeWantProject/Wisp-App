import 'package:injectable/injectable.dart';
import 'package:wisp/domain/entities/auth/signin_entity.dart';
import 'package:wisp/domain/repositories/auth/auth_repository.dart';

@injectable
class SignInUseCase {
  final AuthRepository authRepository;

  SignInUseCase(this.authRepository);

  Future<void> signIn(SignInEntity signinEntity) async {
    return await authRepository.signIn(signinEntity);
  }

  Future<void> sendSms(String phoneNumber) async {
    return await authRepository.sendSms(phoneNumber);
  }

  Future<void> verifySms(String code) async {
    return await authRepository.verifyPhone(code);
  }
}
