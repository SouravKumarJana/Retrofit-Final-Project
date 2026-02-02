import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../model/post_model.dart';
part 'post_api_service.g.dart';

@RestApi()
abstract class PostApiService {
  factory PostApiService(Dio dio) = _PostApiService;

  @GET('/posts')
  Future<List<PostModel>> getPosts();

  @POST('/posts')
  Future<PostModel> addPost(@Body() PostModel post);
}
