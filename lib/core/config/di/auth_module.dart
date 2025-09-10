import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:wisp/core/config/di/configurations.config.dart';
import 'package:wisp/core/network/api_service.dart';
import 'package:wisp/data/datasources/auth/remote/auth_api.dart';
import 'package:wisp/data/datasources/auth/remote/auth_remote_datasource.dart';
import 'package:wisp/data/repositoires/auth/auth_repository_impl.dart';
import 'package:wisp/domain/repositories/auth/auth_repository.dart';
import 'package:wisp/domain/usecases/auth/change_password_usecase.dart';
import 'package:wisp/domain/usecases/auth/refresh_token_usecase.dart';
import 'package:wisp/domain/usecases/auth/signin_usecase.dart';
import 'package:wisp/domain/usecases/auth/signup_usecase.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies() => getIt.init();

@module
abstract class NetworkModule {
  @lazySingleton
  ApiService apiService() => ApiService();
}

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

@module
abstract class AuthDataModule {
  @lazySingleton
  AuthApi authApi(ApiService apiService, RefreshTokenUsecase refreshToken) {
    apiService.attachAuthInterceptor(refreshToken);
    return AuthApi(apiService.client);
  }

  @lazySingleton
  AuthRemoteDataSource authRemoteDataSource(AuthApi api) =>
      AuthRemoteDataSourceImpl(api);

  @lazySingleton
  AuthRepository authRepository(AuthRemoteDataSource dataSource) =>
      AuthRepositoryImpl(dataSource as AuthRemoteDataSourceImpl);
}
