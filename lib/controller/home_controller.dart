import 'package:get/get.dart';

class HomeController  {
  final currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }
}
