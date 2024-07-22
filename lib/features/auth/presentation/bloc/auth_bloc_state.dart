part of 'auth_bloc_bloc.dart';

sealed class AuthBlocState {
  const AuthBlocState();
}

final class AuthBlocSuccess extends AuthBlocState {}
final class AuthBlocInitial extends AuthBlocState {}
final class AuthBlocLoading extends AuthBlocState {}
final class AuthBlocError extends AuthBlocState {}
