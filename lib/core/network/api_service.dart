import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService({
    required Dio dio,
  }) : _dio = dio {
    _attachErrorLoggingInterceptor();
  }

  // ========= API 호출 =========
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final res = await _dio.get(path, queryParameters: queryParameters);
      return res;
    } on DioException catch (e) {
      _printDioError(e);
      rethrow; // 필요하면 상위에서 catch
    } catch (e) {
      print("❌ Unknown error: $e");
      rethrow;
    }
  }

  Future<Response> post(String path, Map<String, dynamic> data) async {
    try {
      final res = await _dio.post(path, data: data);
      return res;
    } on DioException catch (e) {
      _printDioError(e);
      rethrow;
    } catch (e) {
      print("❌ Unknown error: $e");
      rethrow;
    }
  }

  Dio get client => _dio;

  // ========= 에러 로깅 인터셉터 =========
  void _attachErrorLoggingInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, handler) {
          _printDioError(e);
          handler.next(e); // 에러를 계속 전달
        },
      ),
    );
  }

  void _printDioError(DioException e) {
    print("❌ [DioError] -----------------------------");
    print("Status Code: ${e.response?.statusCode}");
    print("Data       : ${e.response?.data}");
    print("Message    : ${e.message}");
    print("------------------------------------------");
  }
}
