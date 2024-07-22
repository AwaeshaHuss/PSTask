part of 'post_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class GetAllPostsEvent extends PostsEvent {
  BuildContext context;

  GetAllPostsEvent(this.context);

  @override
  List<Object> get props => [context];
}

class RefreshPostsEvent extends PostsEvent {}
