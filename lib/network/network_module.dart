import 'package:dio/dio.dart';
import '../core/config/base_url_config.dart';
import 'rest_client.dart';
import 'package:get/get.dart';

class NetworkModule {
  static void prepareDio() {
    Get.lazyPut<Dio>(() => Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
         headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        connectTimeout: const Duration(seconds: 30),
      ),
    ), fenix: true);

    Get.lazyPut<RestClient>(
      () => RestClient(Get.find<Dio>()),
      fenix: true,
    );
  }
}
