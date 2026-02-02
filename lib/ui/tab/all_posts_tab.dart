import 'package:flutter/material.dart';
import '../../controller/post_controller.dart';
class AllPostsPage extends StatelessWidget {
  final PostController controller;
  const AllPostsPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error != null) {
          return Center(child: Text(controller.error!.message));
        }

        return ListView.builder(
          itemCount: controller.posts.length,
          itemBuilder: (_, i) => ListTile(
            title: Text(controller.posts[i].title),
            subtitle: Text(controller.posts[i].body),
          ),
        );
      },
    );
  }
}
