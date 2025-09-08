import 'package:wisp/domain/entities/auth/signup_entity.dart';
import 'package:wisp/domain/repositories/auth/auth_repository.dart';

class SignupUsecase {
  final AuthRepository authRepository;

  SignupUsecase(this.authRepository);

  Future<void> call(SignUpEntity signUpEntity) async {
    return await authRepository.signUp(signUpEntity);
  }
}
