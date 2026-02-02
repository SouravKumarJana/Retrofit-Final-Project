import 'package:flutter/material.dart';
import '../../controller/post_controller.dart';
import '../tab/add_post_tab.dart';
import '../tab/all_posts_tab.dart';

class HomeScreen extends StatefulWidget {
  final PostController controller;
  const HomeScreen({super.key, required this.controller});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posts'),),
      body: index == 0
          ? AllPostsPage(controller: widget.controller)
          : AddPostPage(controller: widget.controller),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Posts'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
        ],
      ),
    );
  }
}
