import 'package:dartz/dartz.dart';
import 'package:ps_task/core/errors/failures.dart';
import 'package:ps_task/features/auth/domain/repositories/auth_repositories.dart';

class SendOTPUseCase{
  final AuthRepositories authRepositories;

  SendOTPUseCase(this.authRepositories);

  Future<Either<Failure, Unit>> call(String phoneNumber) async{
    return await authRepositories.sendOTP(phoneNumber);
  }
}