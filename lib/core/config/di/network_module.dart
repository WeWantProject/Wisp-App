import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wisp/core/network/api_service.dart';
import 'package:wisp/data/datasources/auth/remote/auth_api.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio() => Dio(
        BaseOptions(
          baseUrl: dotenv.env['BASE_URL'] ?? '',
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

  @lazySingleton
  FlutterSecureStorage storage() => const FlutterSecureStorage();

  @lazySingleton
  ApiService apiService(Dio dio, FlutterSecureStorage storage) =>
      ApiService(dio: dio, storage: storage);

  @lazySingleton
  AuthApi authApi(Dio dio) => AuthApi(dio);
}
