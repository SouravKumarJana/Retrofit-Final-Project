import 'package:dio/dio.dart';
import 'api_error.dart';
import '../error_handling/https_status_code.dart';
import '../constants/app_strings.dart';

class ApiErrorMapper {

  static ApiError fromDio(DioException error) {

    if (error.type == DioExceptionType.connectionTimeout ||    /// handle Network Error separately
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError) {

      return ApiError(
        statusCode: HttpStatusCode.gatewayTimeout,
        message: AppStrings.noIntrrnetConnection,
      );
    }

    final statusCode = HttpStatusCode.from(
      error.response?.statusCode,
    );

    return ApiError(
      statusCode: statusCode,
      message: _resolveMessage(statusCode, error),
    );
  }

  static String _resolveMessage(
    HttpStatusCode status,
    DioException error,
  ) {

    switch (status) {

      case HttpStatusCode.badRequest:
        return "Invalid request";

      case HttpStatusCode.unauthorized:
        return "Session expired. Please login again";

      case HttpStatusCode.forbidden:
        return "Access denied";

      case HttpStatusCode.notFound:
        return "Resource not found";

      case HttpStatusCode.conflict:
        return "Conflict occurred";

      case HttpStatusCode.badGateway:
      case HttpStatusCode.serviceUnavailable:
      case HttpStatusCode.gatewayTimeout:
        return "Server unavailable. Try again later";

      case HttpStatusCode.internalServerError:
      default:
        return error.response?.data?["message"] ??
            error.message ??
            AppStrings.somethingWentWrong;
    }
  }
}
