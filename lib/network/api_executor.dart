import 'package:dio/dio.dart';
import '../network/api_error.dart';
import '../network/https_status_code.dart';
class ApiExecutor {
  Future<T> execute<T>(Future<T> Function() apiCall) async {
    try {
      return await apiCall();
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  ApiError _mapError(DioException e) {
    if (e.response != null) {
      final status = HttpStatusCode.from(e.response!.statusCode);
      return ApiError(
        statusCode: status,
        message: 'Request failed (${status.code})',
      );
    }

    return ApiError(
      statusCode: HttpStatusCode.badGateway,
      message: 'Network error',
    );
  }
}
