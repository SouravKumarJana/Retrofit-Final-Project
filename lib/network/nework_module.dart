import 'package:dio/dio.dart';
import '../core/config/base_url_config.dart';
import 'rest_client.dart';

class NetworkModule {

  static Dio prepareDio(String baseUrl) {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }

  static RestClient getRestClient() {
    return RestClient(prepareDio(AppConfig.baseUrl));
  }
}
