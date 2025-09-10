import 'package:wisp/domain/entities/auth/signup_entity.dart';
import 'package:wisp/domain/repositories/auth/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase(this.authRepository);

  Future<void> signUp(SignUpEntity signUpEntity) async {
    return await authRepository.signUp(signUpEntity);
  }
}
