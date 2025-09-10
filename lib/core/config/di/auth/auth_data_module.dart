import 'package:injectable/injectable.dart';
import 'package:wisp/data/datasources/auth/remote/auth_api.dart';
import 'package:wisp/data/datasources/auth/remote/auth_remote_datasource.dart';
import 'package:wisp/data/repositoires/auth/auth_repository_impl.dart';
import 'package:wisp/domain/repositories/auth/auth_repository.dart';

@module
abstract class AuthDataModule {
  @lazySingleton
  AuthRemoteDataSource authRemoteDataSource(AuthApi api) =>
      AuthRemoteDataSourceImpl(api);

  @lazySingleton
  AuthRepository authRepository(AuthRemoteDataSource dataSource) =>
      AuthRepositoryImpl(dataSource as AuthRemoteDataSourceImpl);
}
