import 'package:injectable/injectable.dart';
import 'package:wisp/domain/repositories/auth/auth_repository.dart';
import 'package:wisp/domain/usecases/auth/change_password_usecase.dart';
import 'package:wisp/domain/usecases/auth/refresh_token_usecase.dart';
import 'package:wisp/domain/usecases/auth/signin_usecase.dart';
import 'package:wisp/domain/usecases/auth/signup_usecase.dart';

@module
abstract class AuthModule {
  @lazySingleton
  RefreshTokenUsecase refreshTokenUseCase(AuthRepository repository) =>
      RefreshTokenUsecase(repository);

  @lazySingleton
  SignInUseCase signInUseCase(AuthRepository repository) =>
      SignInUseCase(repository);

  @lazySingleton
  SignUpUseCase signUpUseCase(AuthRepository repository) =>
      SignUpUseCase(repository);

  @lazySingleton
  ChangePasswordUsecase changePasswordUsecase(AuthRepository repository) =>
      ChangePasswordUsecase(repository);
}
