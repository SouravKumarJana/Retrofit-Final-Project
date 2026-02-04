import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../network/rest_client.dart';
import '../network/http_status_code.dart';
import '../network/network_module.dart';

/// Type definition for custom API error handlers.
/// Returns a [Future<bool>] indicating if the error was handled.
typedef ApiErrorHandler = Future<bool> Function(DioException error);

/// BaseController provides common API call handling logic for all controllers.
/// It manages loading indicators, error handling, and logging for API requests.
/// Extend this class to inherit robust API call patterns across your app. 🚀
class BaseController extends ChangeNotifier {
  bool isLoading = false;

  /// Provides access to the [RestClient] instance.
  RestClient get restClient => NetworkModule.getRestClient();

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  /// Calls an API and handles loading, error reporting, and custom error logic.
  ///
  /// [request]: The API call to execute.
  /// [apiErrorHandler]: Optional custom error handler for API errors.
  /// [rethrowError]: If true, rethrows errors after handling.
  /// [reportError]: If true, logs errors for debugging.
  /// [showLoading]: If true, automatically manages the [isLoading] state.
  ///
  /// Returns the API response of type [T], or null if an error occurs.
  Future<T?> callApi<T>(
    Future<T> request, {
    ApiErrorHandler? apiErrorHandler,
    bool rethrowError = false,
    bool reportError = true,
    bool showLoading = true,
  }) async {
    if (showLoading) setLoading(true);
    try {
      final response = await request;
      return response;
    } on DioException catch (dioError) {
      // 🌐 Handle specific HTTP status codes for better UX
      if (dioError.response?.statusCode == HttpStatusCode.badGateway.code) {
        // 502: Server is down
        debugPrint('⚠️ Server is down, please try again later.');
      } else if (dioError.response?.statusCode == HttpStatusCode.unauthorized.code) {
        // 401: Unauthorized
        debugPrint('🔒 Unauthorized access');
      } else if (dioError.response?.statusCode == HttpStatusCode.badRequest.code) {
        // 400: Bad request
        debugPrint('🚫 Bad Request access');
      } else if (dioError.response?.statusCode == HttpStatusCode.forbidden.code) {
        // 403: Forbidden
        debugPrint('🚫 Forbidden access');
      } else if (dioError.response?.statusCode == HttpStatusCode.notFound.code) {
        // 404: Not found
        debugPrint('❓ Resource not found');
      } else if (dioError.response?.statusCode == HttpStatusCode.internalServerError.code) {
        // 500: Internal server error
        debugPrint('💥 Internal server error');
      } else {
        // Other status codes
        debugPrint('API call error with status code: ${dioError.response?.statusCode}');
      }

      // 🛠️ Use custom error handler if provided, else fallback to default
      if (apiErrorHandler != null) {
        final result = await apiErrorHandler(dioError);
        if (!result) {
          await onResponseError(dioError);
        }
      } else {
        await onResponseError(dioError);
      }
    } catch (error) {
      if (rethrowError) rethrow;
      if (reportError) {
        // 📝 Log unexpected errors for debugging
        final logErrorMessage = 'callApi method error :: Error -> ${error.runtimeType} => $error';
        debugPrint(logErrorMessage);
      }
    } finally {
      if (showLoading) setLoading(false);
    }
    // Return null if an error occurred
    return null;
  }

  /// Handles API response errors by logging detailed information for debugging.
  ///
  /// [error]: The DioException thrown during the API call.
  Future<void> onResponseError(DioException error) async {
    try {
      final url = error.requestOptions.uri.toString();
      final headers = error.requestOptions.headers;
      final errorStatusCode = error.response?.statusCode;
      // 🐞 Log all relevant error details for troubleshooting
      debugPrint('onResponseError: $errorStatusCode || $url || $headers');
    } catch (e) {
      // Catch and log any exceptions thrown during error handling itself.
      debugPrint('Exception in onResponseError: ${e.toString()}');
      return;
    }
  }
}
