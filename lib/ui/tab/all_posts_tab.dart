import 'package:flutter/material.dart';
import '../../controller/post_controller.dart';

class AllPostsPage extends StatefulWidget {
  final PostController controller;
  const AllPostsPage({super.key, required this.controller});

  @override
  State<AllPostsPage> createState() => _AllPostsPageState();
}

class _AllPostsPageState extends State<AllPostsPage> {
  @override
  void initState() {
    super.initState();
    widget.controller.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        if (widget.controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (widget.controller.errorMessage != null) {
          return Center(child: Text(widget.controller.errorMessage!));
        }

        return RefreshIndicator(
          onRefresh: widget.controller.getPosts,
          child: ListView.builder(
            itemCount: widget.controller.posts.length,
            itemBuilder: (_, i) => ListTile(
              title: Text(widget.controller.posts[i].title),
              subtitle: Text(widget.controller.posts[i].body),
            ),
          ),
        );
      },
    );
  }
}
