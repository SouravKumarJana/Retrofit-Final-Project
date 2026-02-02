import 'package:flutter/material.dart';
import '../../controller/post_controller.dart';
import '../../model/post_model.dart';

class AddPostPage extends StatefulWidget {
  final PostController controller;

  const AddPostPage({super.key, required this.controller});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  late final TextEditingController titleCtrl;
  late final TextEditingController bodyCtrl;

  @override
  void initState() {
    super.initState();
    titleCtrl = TextEditingController();
    bodyCtrl = TextEditingController();
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    bodyCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (titleCtrl.text.isEmpty || bodyCtrl.text.isEmpty) return;

    await widget.controller.createPost(
      PostModel(
        userId: 1,
        title: titleCtrl.text,
        body: bodyCtrl.text,
      ),
    );

    if (widget.controller.error == null) {
      titleCtrl.clear();
      bodyCtrl.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: titleCtrl,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: bodyCtrl,
            decoration: const InputDecoration(
              labelText: 'Body',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: widget.controller.isLoading ? null : _submit,
            child: widget.controller.isLoading
                ? const CircularProgressIndicator()
                : const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
