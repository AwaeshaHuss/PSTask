import 'package:dartz/dartz.dart';
import 'package:ps_task/core/errors/failures.dart';
import 'package:ps_task/features/home/domain/entities/post_entity.dart';
import 'package:ps_task/features/home/domain/repositories/post_repositories.dart';

class GetPostsUseCase{
  final PostRepositories postRepositories;

  GetPostsUseCase(this.postRepositories);

  Future<Either<Failure, List<PostEntity>>> call() async{
    return await postRepositories.getPosts();
  }
}