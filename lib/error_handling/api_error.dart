import '../error_handling/https_status_code.dart';

class ApiError {
  final HttpStatusCode statusCode;
  final String message;

  ApiError({
    required this.statusCode,
    required this.message,
  });
}
