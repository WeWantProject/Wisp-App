import 'package:injectable/injectable.dart';
import 'package:wisp/core/network/api_service.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  ApiService apiService() => ApiService();
}
