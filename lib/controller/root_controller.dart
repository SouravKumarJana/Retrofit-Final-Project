import '../controller/post_controller.dart';
import '../network/dio_client.dart';
import '../service/post_api_service.dart';
import '../api_call_handler/post_api_caller.dart';

class AppRoot {
  static PostController createPostController() {
    final dio = DioClient.create(
      baseUrl: 'https://jsonplaceholder.typicode.com',
    );

    final apiService = PostApiService(dio);
    final apiCaller = PostApiCaller(apiService);

    return PostController(apiCaller);
  }
}
