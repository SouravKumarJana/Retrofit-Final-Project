import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/post_controller.dart';

class AllPostsPage extends StatelessWidget {

  final PostController postController = Get.find<PostController>();


  AllPostsPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Obx(() {

      if (postController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (postController.posts.isEmpty) {
        return const Center(child: Text("No Posts Found"));
      }

      return RefreshIndicator(
        onRefresh: postController.getAllPosts,
        child: ListView.builder(
          itemCount: postController.posts.length,
          itemBuilder: (_, i) => ListTile(
            title: Text(postController.posts[i].title),
            subtitle: Text(postController.posts[i].body),
          ),
        ),
      );
   });

  }
}
