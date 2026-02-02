import 'package:flutter/material.dart';
import '../model/post_model.dart';
import '../network/api_error.dart';
import '../api_call_handler/post_api_caller.dart';

class PostController extends ChangeNotifier {
  final PostApiCaller apiCaller;

  PostController(this.apiCaller);

  bool isLoading = false;
  List<PostModel> posts = [];
  ApiError? error;

  Future<void> loadPosts() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      posts = await apiCaller.getPosts();
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
      final createdPost = await apiCaller.addPost(post);
      posts.insert(0, createdPost);
    } on ApiError catch (e) {
      error = e;
    }

    isLoading = false;
    notifyListeners();
  }
}
