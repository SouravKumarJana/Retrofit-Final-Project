import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../page/add_posts_page.dart';
import '../page/all_posts_page.dart';
import '../../constants/app_strings.dart';
import '../../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {

  HomeScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {

    return Obx(() => Scaffold(
          appBar: AppBar(title: const Text(AppStrings.appName)),

          body: homeController.currentIndex.value == 0
              ? AllPostsPage()
              : AddPostPage(),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: homeController.currentIndex.value,
            onTap: homeController.changeTab,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list), label: AppStrings.firstScreenLabel),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add), label: AppStrings.secondScreenLabel),
            ],
          ),
        ));
  }
}
