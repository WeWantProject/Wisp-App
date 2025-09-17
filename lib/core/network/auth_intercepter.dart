import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wisp/domain/usecases/auth/refresh_token_usecase.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final RefreshTokenUseCase refreshTokenUseCase;
  final Dio dio;

  AuthInterceptor({
    required this.storage,
    required this.refreshTokenUseCase,
    required this.dio,
  });

  static const _accessTokenKey = 'accesstoken';
  static const _refreshTokenKey = 'refreshToken';

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await storage.read(key: _accessTokenKey);
    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshToken = await storage.read(key: _refreshTokenKey);
      if (refreshToken != null) {
        try {
          final newToken = await refreshTokenUseCase.refreshToken(refreshToken);
          await storage.write(
            key: _accessTokenKey,
            value: newToken.accessToken,
          );
          await storage.write(
            key: _refreshTokenKey,
            value: newToken.refreshToken,
          );
          final opts = err.requestOptions;
          opts.headers["Authorization"] = "Bearer ${newToken.accessToken}";
          final response = await dio.fetch(opts);
          return handler.resolve(response);
        } catch (_) {
          return handler.next(err);
        }
      }
    }
    handler.next(err);
  }
}
