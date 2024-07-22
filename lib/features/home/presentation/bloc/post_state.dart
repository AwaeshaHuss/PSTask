part of 'post_bloc.dart';

enum PostsStateStatus {
  initial,
  success,
  error,
  loading,
}

extension PostsStateStatusX on PostsStateStatus {
  bool get isInitial => this == PostsStateStatus.initial;
  bool get isSuccess => this == PostsStateStatus.success;
  bool get isError => this == PostsStateStatus.error;
  bool get isLoading => this == PostsStateStatus.loading;
}

class PostState extends Equatable {
  final PostsStateStatus status;
  final List<PostModel> postsList;

  const PostState({
    this.status = PostsStateStatus.initial,
    this.postsList = const [],
  });

  PostState copyWith({
    PostsStateStatus? status,
    List<PostModel>? postsList,
  }) {
    return PostState(
      status: status ?? this.status,
      postsList: postsList ?? this.postsList,
    );
  }

  @override
  List<Object?> get props => [
        status,
        postsList,
      ];
}