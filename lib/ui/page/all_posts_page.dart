import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/post_controller.dart';

class AllPostsPage extends StatelessWidget {

  final PostController controller = Get.find<PostController>();

  AllPostsPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Obx(() {

      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text(controller.errorMessage.value));
      }

      return RefreshIndicator(
        onRefresh: controller.getAllPosts,
        child: ListView.builder(
          itemCount: controller.posts.length,
          itemBuilder: (_, i) => ListTile(
            title: Text(controller.posts[i].title),
            subtitle: Text(controller.posts[i].body),
          ),
        ),
      );
    });
  }
}
