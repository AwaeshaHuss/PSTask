import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ps_task/core/errors/exceptions.dart';
import 'package:ps_task/core/errors/failures.dart';
import 'package:ps_task/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:ps_task/features/auth/domain/entities/user_entity.dart';
import 'package:ps_task/features/auth/domain/repositories/auth_repositories.dart';

class AuthRepositoriesImpl implements AuthRepositories{
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoriesImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> loadUserData() async{
   try {
      final user = await authRemoteDataSource.loadUserData();
      return Right(user.toEntity());
    } on FirebaseException {
      return Left(ServerFailure());
    } on OfflineException {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> login(String mobile, String password) async{
     try {
      await authRemoteDataSource.login(mobile, password);

        return const Right(unit);
      } on UserNotFoundException{
        return Left(UserNotFoundFailure());
      } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return Left(IncorrectPasswordFailure());
      } else if (e.code == 'user-not-found') {
        return Left(UserNotFoundFailure());
      }
      return Left(ServerFailure());
    } on OfflineException {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async{
    try {
      await authRemoteDataSource.logout();
      return const Right(unit);
    } on OfflineException {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> register(String email, String password, String phoneNumber, String fullName, int age, String gender, String mobileRegx, String passwordRegx) async{
    try {
      await authRemoteDataSource.register(email, password, phoneNumber, fullName, age, gender, mobileRegx, passwordRegx);
      return const Right(unit);
    } on FirebaseAuthException {
      return Left(ServerFailure());
    } on OfflineException {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> sendOTP(String phoneNumber) async{
     try {
      await authRemoteDataSource.sendOTP(phoneNumber);
      return const Right(unit);
    } on OfflineException {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyOTP(String verificationId, String otpCode) async{
    try {
      await authRemoteDataSource.verifyOTP(verificationId, otpCode);
        return const Right(unit);
      } on InvalidOTPException {
        return Left(InvalidOTPFailure());
      }
  }
}