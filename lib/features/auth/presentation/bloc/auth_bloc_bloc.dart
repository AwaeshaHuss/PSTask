import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ps_task/features/auth/domain/usecases/load_userdata_usecase.dart';
import 'package:ps_task/features/auth/domain/usecases/login_usecase.dart';
import 'package:ps_task/features/auth/domain/usecases/logout_usecase.dart';
import 'package:ps_task/features/auth/domain/usecases/register_usecase.dart';
import 'package:ps_task/features/auth/domain/usecases/sendotp_usecase.dart';
import 'package:ps_task/features/auth/domain/usecases/verifyotp_usecase.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogOutUseCase logOutUseCase;
  final SendOTPUseCase sendOTPUseCase;
  final VerifyOTPUseCase verifyOTPUseCase;
  final LoadUserDataUseCase loadUserDataUseCase;

  AuthBlocBloc({required this.loginUseCase, required this.registerUseCase, required this.logOutUseCase, required this.sendOTPUseCase, required this.verifyOTPUseCase, required this.loadUserDataUseCase}) : super(AuthBlocInitial()) {
    on<LoginEvent>(_login);
    on<RegisterEvent>(_register);
    on<LogoutEvent>(_logout);
    on<SendOTPEvent>(_sendOTP);
    on<verifyOTPEvent>(_verifyOTP);
    on<LoadUserDataEvent>(_loadUserData);
  }

  FutureOr<void> _login(AuthBlocEvent event, Emitter<AuthBlocState> emit) {
  }

  FutureOr<void> _register(RegisterEvent event, Emitter<AuthBlocState> emit) {
  }

  FutureOr<void> _logout(LogoutEvent event, Emitter<AuthBlocState> emit) {
  }

  FutureOr<void> _sendOTP(SendOTPEvent event, Emitter<AuthBlocState> emit) {
  }

  FutureOr<void> _verifyOTP(verifyOTPEvent event, Emitter<AuthBlocState> emit) {
  }

  FutureOr<void> _loadUserData(LoadUserDataEvent event, Emitter<AuthBlocState> emit) {
  }
}
