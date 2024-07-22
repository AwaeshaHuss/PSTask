part of 'auth_bloc_bloc.dart';

sealed class AuthBlocState {
  const AuthBlocState();
}

final class AuthBlocInitial extends AuthBlocState {}
