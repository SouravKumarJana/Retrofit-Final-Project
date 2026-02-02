import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../model/post_model.dart';
import '../network/api_error.dart';
import '../network/https_status_code.dart';
import '../service/post_api_service.dart';

class PostController extends ChangeNotifier {
  final PostApiService api;

  PostController(this.api);

  bool isLoading = false;
  List<PostModel> posts = [];
  ApiError? error;

  Future<void> loadPosts() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      posts = await api.getPosts();
    } on DioException catch (e) {
      error = _mapError(e);
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> createPost(PostModel post) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      await api.addPost(post);
      posts.insert(0, post);

    } on DioException catch (e) {
      error = _mapError(e);
    }

    isLoading = false;
    notifyListeners();
  }

  ApiError _mapError(DioException e) {
  // Case 1: Server responded with status code
  if (e.response != null) {
    final status = HttpStatusCode.from(e.response!.statusCode);

    switch (status) {
      case HttpStatusCode.badRequest:
        return ApiError(
          statusCode: status,
          message: 'Bad request',
        );

      case HttpStatusCode.unauthorized:
        return ApiError(
          statusCode: status,
          message: 'Unauthorized access',
        );

      case HttpStatusCode.notFound:
        return ApiError(
          statusCode: status,
          message: 'Resource not found',
        );

      case HttpStatusCode.internalServerError:
        return ApiError(
          statusCode: status,
          message: 'Server error',
        );

      default:
        return ApiError(
          statusCode: status,
          message: 'Request failed (${status.code})',
        );
    }
  }

  // Case 2: No response → network / client issue
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
      return ApiError(
        statusCode: HttpStatusCode.gatewayTimeout,
        message: 'Request timeout',
      );

    case DioExceptionType.connectionError:
      return ApiError(
        statusCode: HttpStatusCode.badGateway,
        message: 'No internet connection',
      );

    default:
      return ApiError(
        statusCode: HttpStatusCode.internalServerError,
        message: 'Unexpected client error',
      );
  }
}

}
