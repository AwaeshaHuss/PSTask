import 'package:equatable/equatable.dart';

class PostEntity extends Equatable{
  final int? id;
  final int? uid;
  final String title;
  final String body;

  const PostEntity({this.id, this.uid, required this.title, required this.body});

  
  @override
  List<Object?> get props => [id, uid, title, body];
}