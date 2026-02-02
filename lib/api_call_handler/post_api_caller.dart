import 'package:dio/dio.dart';
import '../model/post_model.dart';
import '../network/api_error.dart';
import '../network/https_status_code.dart';
import '../service/post_api_service.dart';

class PostApiCaller {
  final PostApiService api;

  PostApiCaller(this.api);

  Future<List<PostModel>> getPosts() async {
    try {
      return await api.getPosts();
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Future<PostModel> addPost(PostModel post) async {
    try {
      return await api.addPost(post);
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
