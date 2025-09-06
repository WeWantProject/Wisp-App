import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BASE_URL'] ?? "",
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );

  final storage = const FlutterSecureStorage();

  ApiService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await storage.read(key: "access_token");

          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },
      ),
    );
  }

  Future<Response> get(String path) async => await _dio.get(path);
  Future<Response> post(String path, Map<String, dynamic> data) async =>
      await _dio.post(path, data: data);
}
