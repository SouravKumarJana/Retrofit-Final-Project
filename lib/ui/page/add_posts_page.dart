import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/post_controller.dart';
import '../../constants/app_strings.dart';

class AddPostPage extends StatelessWidget {

  final PostController controller = Get.find<PostController>();

  AddPostPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: controller.postsTitleCtrl,
            decoration: const InputDecoration(
              labelText: AppStrings.postTitleLabel,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller.postsBodyCtrl,
            decoration: const InputDecoration(
              labelText: AppStrings.postBodyLabel,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Obx(() => ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : controller.addPost,
                child: controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text("Submit"),
              )),
        ],
      ),
    );
  }
}
