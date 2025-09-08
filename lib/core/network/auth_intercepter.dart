import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wisp/domain/usecases/auth/refresh_token_usecase.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final RefreshTokenUsecase refreshTokenUseCase;

  AuthInterceptor({required this.storage, required this.refreshTokenUseCase});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await storage.read(key: "access_token");
    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }
    handler.next(options);
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
          final cloneReq = await Dio().fetch(opts);
          return handler.resolve(cloneReq);
        } catch (_) {
          return handler.next(err);
        }
      }
    }
    handler.next(err);
  }
}
