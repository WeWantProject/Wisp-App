import 'package:wisp/domain/entities/auth/signin_entity.dart';
import 'package:wisp/domain/entities/auth/token_entity.dart';
import 'package:wisp/domain/repositories/auth/auth_repository.dart';

class SigninUsecase {
  final AuthRepository authRepository;

  SigninUsecase(this.authRepository);

  Future<TokenEntity> signIn(SignInEntity signInEntity) async {
    return await authRepository.signIn(signInEntity);
  }
}
