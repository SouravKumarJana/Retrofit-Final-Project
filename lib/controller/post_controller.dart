import 'package:flutter/material.dart';
import '../base/base_controller.dart';
import '../model/post_model.dart';

class PostController extends BaseController {
  final TextEditingController poststitleCtrl = TextEditingController();
  final TextEditingController postsbodyCtrl = TextEditingController();
  List<PostRequest> posts = [];
  String? errorMessage;

  Future<void> getAllPosts() async {
    errorMessage = null;

    final result = await callApi(restClient.getPosts());

    if (result != null) {
      posts = result;
    } else {
      errorMessage = 'Failed to load posts';
    }
  }

  Future<bool> createNewPost() async {
    if (poststitleCtrl.text.isEmpty || postsbodyCtrl.text.isEmpty) return false;

    final postRequest = PostRequest(userId: 1, title: poststitleCtrl.text.trim(), body: postsbodyCtrl.text.trim());

    final result = await callApi(restClient.addPost(postRequest), apiErrorHandler: (error) async => false);

    if (result != null) {
      debugPrint('Post Created: $result');
      poststitleCtrl.clear();
      postsbodyCtrl.clear();
      return true;
    }
    return false;
  }

  void submitPost(BuildContext context) async {
    final success = await createNewPost();
    if (success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Post added successfully!')));
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to add post')));
    }
  }

  @override
  void dispose() {
    poststitleCtrl.dispose();
    postsbodyCtrl.dispose();
    super.dispose();
  }
}