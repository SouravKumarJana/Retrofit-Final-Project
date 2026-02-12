import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/post_controller.dart';
import '../page/add_posts_page.dart';
import '../page/all_posts_page.dart';
import '../../constants/app_strings.dart';

class HomeScreen extends StatelessWidget {

  HomeScreen({super.key});

  final PostController controller = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {

    return Obx(() => Scaffold(
          appBar: AppBar(title: const Text(AppStrings.appName)),

          body: controller.currentIndex.value == 0
              ? AllPostsPage()
              : AddPostPage(),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeTab,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list), label: AppStrings.firstScreenLabel),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add), label: AppStrings.secondScreeLabel),
            ],
          ),
        ));
  }
}
