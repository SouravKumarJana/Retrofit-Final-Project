import 'package:get/get.dart';
import '../../../base/base_controller.dart';

class PostController extends BaseController {

  @override
  void onInit() {
    super.onInit();
    getAllPosts();
  }

  Future<void> getAllPosts() async {
    final result = await callApi(restClient.getPosts());
    if (result != null) {
      posts.assignAll(result);
    }
  }
}

