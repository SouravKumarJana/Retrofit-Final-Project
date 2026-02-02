import '../controller/post_controller.dart';
import '../network/dio_client.dart';
import '../network/api_executor.dart';
import '../service/post_api_service.dart';

class AppRoot {
  static PostController createPostController() {
    final dio = DioClient.create(
      baseUrl: 'https://jsonplaceholder.typicode.com',
    );

    final apiService = PostApiService(dio);
    final executor = ApiExecutor();

    return PostController(apiService, executor);
  }
}
