import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/posts_model.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {

  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET('/posts')
  Future<List<PostsModel>> getPosts();

  @POST('/posts')
  Future<PostsModel> addPost(@Body() PostsModel post);
}
