import 'package:dartz/dartz.dart';
import 'package:ps_task/core/errors/exceptions.dart';
import 'package:ps_task/core/errors/failures.dart';
import 'package:ps_task/features/home/data/datasources/post_data_sources.dart';
import 'package:ps_task/features/home/domain/entities/post_entity.dart';
import 'package:ps_task/features/home/domain/repositories/post_repositories.dart';

class PostRepositoriesImpl implements PostRepositories{
  final PostsRemoteDataSource postsRemoteDataSource;

  PostRepositoriesImpl(this.postsRemoteDataSource);

  @override
  Future<Either<Failure, List<PostEntity>>> getPosts() async{
    try {
      final posts = await postsRemoteDataSource.getPosts();
      return Right(posts);
    } on ServerException {
      return Left(ServerFailure());
    } on OfflineException{
      return Left(OfflineFailure());
    }
  }
}