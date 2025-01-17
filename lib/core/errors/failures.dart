import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class IncorrectPasswordFailure extends Failure{
  @override
  List<Object?> get props => [];
}

class UserNotFoundFailure extends Failure{
  @override
  List<Object?> get props => [];
}

class InvalidOTPFailure extends Failure{
  @override
  List<Object?> get props => [];
}