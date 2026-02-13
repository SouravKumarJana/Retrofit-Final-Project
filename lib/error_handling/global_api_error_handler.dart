import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'api_error_mapper.dart';
import '../constants/app_strings.dart';

class GlobalErrorHandler {

  static Future<bool> handle(DioException error) async {

    final apiError = ApiErrorMapper.fromDio(error);

    Get.snackbar(
      AppStrings.error,
      apiError.message,
      snackPosition: SnackPosition.BOTTOM,
    );

    return false;
  }

  static Future<void> handleUnknownError(Object error) async {   //JSON parsing errors come here

    Get.snackbar(
      AppStrings.error,
      AppStrings.parsingErrorOccurred,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white, 
    );
  }
}
