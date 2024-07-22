import 'package:dartz/dartz.dart';
import 'package:ps_task/core/errors/failures.dart';
import 'package:ps_task/features/auth/domain/repositories/auth_repositories.dart';

class LoginUseCase{
  final AuthRepositories authRepository;

  LoginUseCase(this.authRepository);

  Future<Either<Failure, Unit>> call(String mobile, String password) async{
    return await authRepository.login(mobile, password);
  }
}