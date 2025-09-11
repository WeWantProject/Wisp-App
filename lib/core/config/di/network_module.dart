import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:wisp/core/network/api_service.dart';
import 'package:wisp/data/datasources/auth/remote/auth_api.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio() => Dio();

  @lazySingleton
  FlutterSecureStorage storage() => const FlutterSecureStorage();

  @lazySingleton
  ApiService apiService(Dio dio, FlutterSecureStorage storage) =>
      ApiService(dio: dio, storage: storage);

  @lazySingleton
  AuthApi authApi(Dio dio) => AuthApi(dio);
}
