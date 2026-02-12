import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'api_error_mapper.dart';

class GlobalErrorHandler {

  static Future<bool> handle(DioException error) async {

    final apiError = ApiErrorMapper.fromDio(error);

    Get.snackbar(
      "Error",
      apiError.message,
      snackPosition: SnackPosition.BOTTOM,
    );

    return false;
  }
}
