import 'package:dartz/dartz.dart';
import 'package:ps_task/core/errors/failures.dart';
import 'package:ps_task/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepositories{
  Future<Either<Failure, Unit>> login(String mobile, String password);
  Future<Either<Failure, Unit>> register(String email, String password, String phoneNumber, String fullName, int age, String gender, String mobileRegx, String passwordRegx);
  Future<Either<Failure, Unit>> sendOTP(String phoneNumber);
  Future<Either<Failure, Unit>> verifyOTP(String verificationId, String otpCode);
  Future<Either<Failure, Unit>> logout();
  Future<Either<Failure, UserEntity>> loadUserData();
}