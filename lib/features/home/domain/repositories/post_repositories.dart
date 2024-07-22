import 'package:dartz/dartz.dart';
import 'package:ps_task/core/errors/failures.dart';
import 'package:ps_task/features/home/domain/entities/post_entity.dart';

abstract class PostRepositories {
  Future<Either<Failure, List<PostEntity>>> getPosts();
}