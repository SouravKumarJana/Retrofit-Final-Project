import 'package:flutter_application_9/base/base_controller.dart';
import 'package:get/get.dart';
class HomeController extends BaseController {
  final currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }
}
