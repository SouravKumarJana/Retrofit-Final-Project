import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_strings.dart';
import '../../controller/add_post_controller.dart';

class AddPostPage extends StatelessWidget {

  final AddPostController addPostController = Get.find<AddPostController>();


  AddPostPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: addPostController.postsTitleCtrl,
            decoration: const InputDecoration(
              labelText: AppStrings.postTitleLabel,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: addPostController.postsBodyCtrl,
            decoration: const InputDecoration(
              labelText: AppStrings.postBodyLabel,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Obx(() => ElevatedButton(
                onPressed: addPostController.isLoading.value
                    ? null
                    : addPostController.addPost,
                child: addPostController.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text(AppStrings.submit),
              )),
        ],
      ),
    );
  }
}
