import 'package:dartz/dartz.dart';
import 'package:ps_task/core/errors/failures.dart';
import 'package:ps_task/features/auth/domain/entities/user_entity.dart';
import 'package:ps_task/features/auth/domain/repositories/auth_repositories.dart';

class LoadUserDataUseCase{
  final AuthRepositories authRepositories;

  LoadUserDataUseCase(this.authRepositories);

  Future<Either<Failure, UserEntity>> call() async{
    return await authRepositories.loadUserData();
  }
}