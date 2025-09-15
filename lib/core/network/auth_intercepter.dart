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

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    storage.read(key: "access_token").then((token) {
      if (token != null) {
        options.headers["Authorization"] = "Bearer $token";
      }
      handler.next(options);
    }).catchError((_) {
      handler.next(options);
    });
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshToken = await storage.read(key: "refresh_token");
      if (refreshToken != null) {
        try {
          final newToken = await refreshTokenUseCase.refreshToken(refreshToken);
          await storage.write(key: "access_token", value: newToken.accessToken);
          await storage.write(
              key: "refresh_token", value: newToken.refreshToken);
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
