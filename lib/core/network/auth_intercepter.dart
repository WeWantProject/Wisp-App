import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wisp/presentation/auth/controller/auth_controller.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final Ref ref;
  final Dio dio;

  AuthInterceptor({
    required this.storage,
    required this.ref,
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
          ref.read(authControllerProvider.notifier).setTokenExpired();
        } catch (e) {
          storage.deleteAll();
          print(e.toString());
        }
      }
    }
    handler.next(err);
  }
}
