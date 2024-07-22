import 'package:dartz/dartz.dart';
import 'package:ps_task/core/errors/failures.dart';
import 'package:ps_task/features/auth/domain/repositories/auth_repositories.dart';

class LogOutUseCase{
  final AuthRepositories authRepositories;

  LogOutUseCase(this.authRepositories);

  Future<Either<Failure, Unit>> call() async{
    return await authRepositories.logout();
  }
}