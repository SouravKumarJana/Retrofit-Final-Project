import 'package:dio/dio.dart';
import 'rest_client.dart';
import '../core/config/base_url_config.dart';

abstract class NetworkModule {
  static Dio prepareDio(String baseurl) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseurl,
        headers: {'Content-Type': 'application/json; charset=UTF-8', 'Accept': 'application/json'},
      ),
    );

    return dio;
  }

  static RestClient getRestClient() {
    return RestClient(prepareDio(AppConfig.baseurl));
  }
}
