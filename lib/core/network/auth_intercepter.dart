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

  static const _accessTokenKey = 'accessToken';
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
      final refreshTokenExpire = await storage.read(
        key: 'refreshTokenExpiration',
      );
      final now = DateTime.now().toUtc();
      if (refreshToken != null) {
        final refreshTokenExpiration = DateTime.parse(
          refreshTokenExpire!,
        ).toUtc();
        try {
          if (now.isAfter(refreshTokenExpiration)) {
            final response = await refreshTokenUseCase.refreshToken(
              refreshToken,
            );

            await storage.write(
              key: 'accessToken',
              value: response.accessToken,
            );
            await storage.write(
              key: 'refreshToken',
              value: response.refreshToken,
            );
            await storage.write(
              key: 'accessTokenExpiration',
              value: response.accessTokenExpiration.toIso8601String(),
            );
            await storage.write(
              key: 'refreshTokenExpiration',
              value: response.refreshTokenExpiration.toIso8601String(),
            );

            final newAccessToken = storage.read(key: _accessTokenKey);

            final opts = err.requestOptions;
            opts.headers["Authorization"] = "Bearer $newAccessToken";
            final retryResponse = await dio.fetch(opts);
            return handler.resolve(retryResponse);
          }
        } catch (_) {
          // 토큰 갱신 실패시 저장된 토큰 삭제
        }
      }
    }
    handler.next(err);
  }
}
