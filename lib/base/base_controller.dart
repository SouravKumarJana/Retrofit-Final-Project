import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../network/nework_module.dart';
import '../error_handling/global_api_error_handler.dart';
import '../network/rest_client.dart';

typedef ApiErrorHandler = Future<bool> Function(DioException error);

abstract class BaseController extends GetxController {

  final isLoading = false.obs;

  RestClient get restClient => NetworkModule.getRestClient();

  Future<T?> callApi<T>(
    Future<T> request, {
    ApiErrorHandler? apiErrorHandler,
    bool showLoading = true,
  }) async {

    if (showLoading) isLoading.value = true;

    try {
      return await request;

    } on DioException catch (dioError) {

      bool handled = false;

      if (apiErrorHandler != null) {
        handled = await apiErrorHandler(dioError);
      }

      if (!handled) {
        await GlobalErrorHandler.handle(dioError);
      }

    } finally {
      if (showLoading) isLoading.value = false;
    }

    return null;
  }
}
