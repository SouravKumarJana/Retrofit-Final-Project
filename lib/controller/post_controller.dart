import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../base/base_controller.dart';
import '../models/post_model.dart';

class PostController extends BaseController {

  final currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }

  final postsTitleCtrl = TextEditingController();
  final postsBodyCtrl = TextEditingController();

  final posts = <PostRequest>[].obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getAllPosts();
  }

  @override
  void onClose() {
    postsTitleCtrl.dispose();
    postsBodyCtrl.dispose();
    super.onClose();
  }

  Future<void> getAllPosts() async {

    errorMessage.value = '';

    final result = await callApi(
      restClient.getPosts(),
    );

    if (result != null) {
      posts.assignAll(result);
    } else {
      errorMessage.value = "Failed to load posts";
    }
  }

  Future<void> addPost() async {

    if (!_validateForm()) return;

    final post = PostRequest(
      userId: 1,
      title: postsTitleCtrl.text.trim(),
      body: postsBodyCtrl.text.trim(),
    );

    final result = await callApi(
      restClient.addPost(post),
    );

    if (result != null) {
      posts.insert(0, post);
      _clearForm();
      Get.snackbar("Success", "Post Added Successfully",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white, 
        backgroundColor: Colors.blueAccent
      );
    }
  }

  bool _validateForm() {
    if (postsTitleCtrl.text.isEmpty || postsBodyCtrl.text.isEmpty) {
      Get.snackbar("Error", "All fields required",
        snackPosition: SnackPosition.BOTTOM, 
        colorText: Colors.white, 
        backgroundColor: Colors.redAccent 
      );
      return false;
    }
    return true;
  }

  void _clearForm() {
    postsTitleCtrl.clear();
    postsBodyCtrl.clear();
  }
}
