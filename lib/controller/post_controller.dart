import 'package:flutter_application_9/models/posts_model.dart';
import 'package:get/get.dart';
import '../../../base/base_controller.dart';

class PostController extends BaseController {
  final posts = <PostsModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    getAllPosts();
  }

  Future<void> getAllPosts() async {
    final result = await callApi(restClient.getPosts());
    if (result != null) {
      posts.assignAll(result);
    }
  }
}

