import 'package:flutter/material.dart';
import 'package:flutter_application_9/controller/post_controller.dart';
import 'package:flutter_application_9/models/posts_model.dart';
import '../base/base_controller.dart';
import '../constants/app_strings.dart';
import 'package:get/get.dart';

class AddPostController extends BaseController {

  final postsTitleCtrl = TextEditingController();
  final postsBodyCtrl = TextEditingController();

  Future<void> addPost() async {
    if (postsTitleCtrl.text.isEmpty || postsBodyCtrl.text.isEmpty) {
      Get.snackbar(AppStrings.error, 
        AppStrings.allFieldsRequired,
        snackPosition: SnackPosition.BOTTOM, 
        backgroundColor: Colors.redAccent, 
        colorText: Colors.white
      );
      return;
    }

    final request = PostsModel(
      userId: 1,
      title: postsTitleCtrl.text.trim(),
      body: postsBodyCtrl.text.trim(),
    );

    final result = await callApi(restClient.addPost(request));

    if (result != null) {
      final postController = Get.find<PostController>();

      postController.posts.insert(0, result);
      postsTitleCtrl.clear();
      postsBodyCtrl.clear();
      Get.snackbar(AppStrings.success, AppStrings.postAddedSuccessfully);
    }
  }

  @override
  void onClose() {
    postsTitleCtrl.dispose();
    postsBodyCtrl.dispose();
    super.onClose();
  }
}
