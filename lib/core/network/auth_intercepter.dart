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
      if (refreshToken != null) {
        try {
          // 🔥 핵심: 별도 Dio 인스턴스 생성 (인터셉터 없음)
          final refreshDio = Dio(
            BaseOptions(
              baseUrl: dio.options.baseUrl,
              connectTimeout: dio.options.connectTimeout,
              receiveTimeout: dio.options.receiveTimeout,
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
              },
            ),
          );

          // 직접 refresh API 호출 (RefreshTokenUseCase 우회)
          final response = await refreshDio.put(
            '/auth/refresh-token',
            data: {'refreshToken': refreshToken},
          );

          final newAccessToken = response.data['accessToken'];
          final newRefreshToken = response.data['refreshToken'];

          await storage.write(key: _accessTokenKey, value: newAccessToken);
          await storage.write(key: _refreshTokenKey, value: newRefreshToken);

          // 원본 요청 재시도
          final opts = err.requestOptions;
          opts.headers["Authorization"] = "Bearer $newAccessToken";
          final retryResponse = await dio.fetch(opts);
          return handler.resolve(retryResponse);
        } catch (_) {
          // 토큰 갱신 실패시 저장된 토큰 삭제
          await storage.delete(key: _accessTokenKey);
          await storage.delete(key: _refreshTokenKey);
          return handler.next(err);
        }
      }
    }
    handler.next(err);
  }
}
