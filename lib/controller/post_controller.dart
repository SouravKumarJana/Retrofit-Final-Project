import 'package:flutter/material.dart';
import '../base/base_controller.dart';
import '../model/post_request.dart';

class PostController extends BaseController {
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController bodyCtrl = TextEditingController();
  List<PostRequest> posts = [];
  String? errorMessage;

  Future<void> getPosts() async {
    errorMessage = null;

    final result = await callApi(restClient.getPosts());

    if (result != null) {
      posts = result;
    } else {
      errorMessage = 'Failed to load posts';
    }
  }

  Future<bool> createNewPost() async {
    if (titleCtrl.text.isEmpty || bodyCtrl.text.isEmpty) return false;

    final postRequest = PostRequest(userId: 1, title: titleCtrl.text.trim(), body: bodyCtrl.text.trim());

    final result = await callApi(restClient.addPost(postRequest), apiErrorHandler: (error) async => false);

    if (result != null) {
      debugPrint('Post Created: $result');
      titleCtrl.clear();
      bodyCtrl.clear();
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
    titleCtrl.dispose();
    bodyCtrl.dispose();
    super.dispose();
  }
}
