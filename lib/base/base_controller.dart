import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../network/rest_client.dart';
import '../network/nework_module.dart';
import '../network/global_api_error_handler.dart';

typedef ApiErrorHandler = Future<bool> Function(DioException error);

class BaseController extends ChangeNotifier {
  bool isLoading = false;

  RestClient get restClient => NetworkModule.getRestClient();

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<T?> callApi<T>(
    Future<T> request, {
    ApiErrorHandler? apiErrorHandler,
    bool rethrowError = false,
    bool reportError = true,
    bool showLoading = true,
    BuildContext? context,
  }) async {
    if (showLoading) setLoading(true);

    try {
      return await request;
    } on DioException catch (dioError) {
      bool handled = false;

      // Controller-level override 
      if (apiErrorHandler != null) {                   //When local ApiErrorHandler is present like addPost
        handled = await apiErrorHandler(dioError);
      }

      // Global fallback
      if (!handled) {                           //
        await GlobalApiErrorHandler.handle(
          dioError,
          context: context,
        );
      }

      if (rethrowError) rethrow;
    } catch (error) {
      if (reportError) {
        debugPrint(
          'callApi error :: ${error.runtimeType} => $error',
        );
      }
    } finally {
      if (showLoading) setLoading(false);
    }

    return null;
  }
}
