import 'package:flutter/material.dart';
import '../ui/screen/home_screen.dart';

class MyApp extends StatelessWidget {
  final controller;
  const MyApp({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(controller: controller),
    );
  }
}