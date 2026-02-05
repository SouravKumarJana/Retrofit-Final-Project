import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../model/post_model.dart';
part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET('/posts')
  Future<List<PostRequest>> getPosts();

  @POST('/posts')
  Future<String> addPost(@Body() PostRequest post);
}
