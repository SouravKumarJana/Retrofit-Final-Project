import 'package:dio/dio.dart';
import 'rest_client.dart';
import '../core/config/config.dart';

/// 🌐 NetworkModule
/// Provides configuration and setup for network requests using Dio.
/// Handles authentication, logging, and header management for all API calls.
abstract class NetworkModule {
  static Dio prepareDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseurl,
        headers: {'Content-Type': 'application/json; charset=UTF-8', 'Accept': 'application/json'},
      ),
    );

    return dio;
  }

  static RestClient getRestClient() {
    return RestClient(prepareDio());
  }
}
