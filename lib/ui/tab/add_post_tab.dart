import 'package:flutter/material.dart';
import '../../controller/post_controller.dart';

class AddPostPage extends StatelessWidget {
  final PostController controller;
  const AddPostPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: controller.titleCtrl,
                decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller.bodyCtrl,
                decoration: const InputDecoration(labelText: 'Body', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: controller.isLoading ? null : () => controller.submitPost(context),
                child: controller.isLoading
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }
}
