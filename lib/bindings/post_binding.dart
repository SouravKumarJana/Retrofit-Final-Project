import 'package:flutter_application_9/controller/add_post_controller.dart';
import 'package:flutter_application_9/controller/home_controller.dart';
import 'package:get/get.dart';
import '../controller/post_controller.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostController>(() => PostController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AddPostController>(() => AddPostController());

  }
}
