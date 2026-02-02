import 'package:flutter/material.dart';
import 'ui/app.dart';
import 'controller/root_controller.dart';
void main() {
  final controller = AppRoot.createPostController();
  runApp(MyApp(controller: controller));
}

