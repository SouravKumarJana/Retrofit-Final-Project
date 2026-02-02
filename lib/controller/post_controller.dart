import 'package:flutter/material.dart';
import '../model/post_model.dart';
import '../network/api_error.dart';
import '../network/api_executor.dart';
import '../service/post_api_service.dart';
class PostController extends ChangeNotifier {
  final PostApiService api;
  final ApiExecutor executor;

  PostController(this.api, this.executor);

  List<PostModel> posts = [];
  ApiError? error;
  bool isLoading = false;

  Future<void> loadPosts() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      posts = await executor.execute(() => api.getPosts());
    } on ApiError catch (e) {
      error = e;
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> createPost(PostModel post) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final created = await executor.execute(() => api.addPost(post));
      posts.insert(0, created);
    } on ApiError catch (e) {
      error = e;
    }

    isLoading = false;
    notifyListeners();
  }
}
