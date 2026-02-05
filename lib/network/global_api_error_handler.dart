import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'api_error_mapper.dart';

class GlobalApiErrorHandler {
  static Future<bool> handle(
    DioException error, {
    BuildContext? context,
  }) async {
    final apiError = ApiErrorMapper.fromDio(error);

    _log(apiError);

    // switch (apiError.statusCode) {
    //   case HttpStatusCode.unauthorized:
    //     // Hree TODO: logout / token refresh
    //     break;

    //   case HttpStatusCode.serviceUnavailable:
    //   case HttpStatusCode.gatewayTimeout:
    //     // Here TODO : retry / offline handling
    //     break;

    //   default:
    //     break;
    // }

    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(apiError.message)),
      );
    }

    // return false => BaseController fallback continues
    return false;
  }

  static void _log(dynamic error) {
    debugPrint(
      'API ERROR => ${error.statusCode} | ${error.message}',
    );
  }
}
