import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wisp/core/network/auth_intercepter.dart';
import 'package:wisp/domain/usecases/auth/refresh_token_usecase.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: dotenv.env['BASE_URL'] ?? "",
    headers: {"Content-Type": "application/json"},
  ));

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  ApiService();

  void attachAuthInterceptor(RefreshTokenUsecase refreshTokenUseCase) {
    _dio.interceptors.add(
      AuthInterceptor(
        storage: storage,
        refreshTokenUseCase: refreshTokenUseCase,
      ),
    );
  }

  Future<Response> get(String path) async => await _dio.get(path);
  Future<Response> post(String path, Map<String, dynamic> data) async =>
      await _dio.post(path, data: data);

  Dio get client => _dio;
}
