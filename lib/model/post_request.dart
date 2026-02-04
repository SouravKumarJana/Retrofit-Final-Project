import 'package:json_annotation/json_annotation.dart';

part 'post_request.g.dart';

@JsonSerializable()
class PostRequest {
  final int? id;
  final int userId;
  final String title;
  final String body;

  PostRequest({this.id, required this.userId, required this.title, required this.body});

  factory PostRequest.fromJson(Map<String, dynamic> json) => _$PostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PostRequestToJson(this);
}
