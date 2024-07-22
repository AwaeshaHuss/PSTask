import 'package:ps_task/features/home/domain/entities/post_entity.dart';

class PostModel extends PostEntity{
  const PostModel({required super.title, required super.body, super.id, super.uid});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      uid: json['userId'],
    );
  }

  PostEntity toEntity() {
    return PostEntity(
      id: id,
      title: title,
      body: body,
      uid: uid,
    );
  }
}