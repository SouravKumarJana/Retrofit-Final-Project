import '../controller/post_controller.dart';
import '../network/dio_client.dart';
import '../service/post_api_service.dart';

class AppRoot {
  static PostController createPostController() {
    final dio = DioClient.create(
      baseUrl: 'https://jsonplaceholder.typicode.com',
    );

    final api = PostApiService(dio);
    return PostController(api);
  }
}
