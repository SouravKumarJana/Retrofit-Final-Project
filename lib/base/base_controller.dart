import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_9/models/posts_model.dart';
import 'package:get/get.dart';
import '../error_handling/global_api_error_handler.dart';
import '../network/rest_client.dart';

typedef ApiErrorHandler = Future<bool> Function(DioException error);

abstract class BaseController extends GetxController {
  final posts = <PostsModel>[].obs;
 
  final isLoading = false.obs;
  final RestClient restClient = Get.find();

  Future<T?> callApi<T>(
    Future<T> request, {
    ApiErrorHandler? apiErrorHandler,
    bool showLoading = true,
  }) async {

    if (showLoading) isLoading.value = true;

    try {

      final response = await request;
      return response;

    } on DioException catch (dioError) {

      bool handled = false;

      if (apiErrorHandler != null) {
        handled = await apiErrorHandler(dioError);
      }

      if (!handled) {
        await GlobalErrorHandler.handle(dioError);
      }

    } catch (e, stackTrace) {    // Handle the Non-Dio exceptions
      

      debugPrint("Non-Dio Exception: $e");
      debugPrintStack(stackTrace: stackTrace);

      await GlobalErrorHandler.handleUnknownError(e);

    } finally {
      if (showLoading) isLoading.value = false;
    }

    return null;
  }
}
