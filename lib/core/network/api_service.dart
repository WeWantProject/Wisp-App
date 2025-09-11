import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wisp/core/network/auth_intercepter.dart';
import 'package:wisp/domain/usecases/auth/refresh_token_usecase.dart';

class ApiService {
  final Dio _dio;
  final FlutterSecureStorage storage;

  ApiService({
    required Dio dio,
    required this.storage,
  }) : _dio = dio;

  void attachAuthInterceptor(RefreshTokenUseCase refreshTokenUseCase) {
    _dio.interceptors.add(
      AuthInterceptor(
        storage: storage,
        refreshTokenUseCase: refreshTokenUseCase,
        dio: _dio,
      ),
    );
  }

  Future<Response> get(String path) async => await _dio.get(path);
  Future<Response> post(String path, Map<String, dynamic> data) async =>
      await _dio.post(path, data: data);

  Dio get client => _dio;
}
