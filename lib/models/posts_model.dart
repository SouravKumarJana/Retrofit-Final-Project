import 'package:json_annotation/json_annotation.dart';

part 'posts_model.g.dart';

@JsonSerializable()
class PostsModel {
  final int? id;
  final int userId;
  final String title;
  final String body;

  PostsModel({
    this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory PostsModel.fromJson(Map<String, dynamic> json) =>
      _$PostsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostsModelToJson(this);
}
