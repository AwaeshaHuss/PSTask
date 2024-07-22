import 'package:dartz/dartz.dart';
import 'package:ps_task/core/errors/failures.dart';
import 'package:ps_task/features/auth/domain/repositories/auth_repositories.dart';

class VerifyOTPUseCase{
  final AuthRepositories authRepositories;

  VerifyOTPUseCase(this.authRepositories);

  Future<Either<Failure, Unit>> call(String verificationId, String otpCode) async{
    return await authRepositories.verifyOTP(verificationId, otpCode);
  }
}