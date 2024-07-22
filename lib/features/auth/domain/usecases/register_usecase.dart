import 'package:dartz/dartz.dart';
import 'package:ps_task/core/errors/failures.dart';
import 'package:ps_task/features/auth/domain/repositories/auth_repositories.dart';

class RegisterUseCase{
  final AuthRepositories authRepositories;

  RegisterUseCase(this.authRepositories);

  Future<Either<Failure, Unit>> call(String email, String password, String phoneNumber, String fullName, int age, String gender, String mobileRegx, String passwordRegx) async{
    return await authRepositories.register(email, password, phoneNumber, fullName, age, gender, mobileRegx, passwordRegx);
  }
}