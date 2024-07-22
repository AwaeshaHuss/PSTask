import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ps_task/core/errors/failures.dart';
import 'package:ps_task/core/theme/app_colors.dart';
import 'package:ps_task/features/auth/domain/entities/user_entity.dart';
import 'package:ps_task/features/auth/domain/usecases/load_userdata_usecase.dart';
import 'package:ps_task/features/auth/domain/usecases/login_usecase.dart';
import 'package:ps_task/features/auth/domain/usecases/logout_usecase.dart';
import 'package:ps_task/features/auth/domain/usecases/register_usecase.dart';
import 'package:ps_task/features/auth/domain/usecases/sendotp_usecase.dart';
import 'package:ps_task/features/auth/domain/usecases/verifyotp_usecase.dart';
import 'package:ps_task/features/auth/presentation/screens/login_screen.dart';

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

  static AuthBlocBloc get(context) => BlocProvider.of(context);

  FutureOr<void> _login(LoginEvent event, Emitter<AuthBlocState> emit) async{
    emit(AuthBlocLoading());
    Either<Failure, Unit> result;
   result = await loginUseCase.call(event.mobile, event.password);
   result.fold((l) {
    ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Container(color: AppColors.red, child: const Text('error logginig user'),)));
      emit((AuthBlocError()));
   }, 
   (r) {
    ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Container(color: AppColors.green, child: const Text('user loggedIn successfully'),)));
      emit((AuthBlocSuccess()));
   });
  }

  FutureOr<void> _register(RegisterEvent event, Emitter<AuthBlocState> emit) async{
    emit(AuthBlocLoading());
    Either<Failure, Unit> result;
   result = await registerUseCase.call(event.email, event.password, event.phoneNumber, event.fullName, 
   event.age, event.gender, event.mobileRegx,event.passwordRegx);
   result.fold((l) {
    ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Container(color: AppColors.red, child: const Text('error crating user'),)));
      emit((AuthBlocError()));
   }, 
   (r) {
    ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Container(color: AppColors.green, child: const Text('user registed successfully'),)));
      emit((AuthBlocSuccess()));
   });
  }

  FutureOr<void> _logout(LogoutEvent event, Emitter<AuthBlocState> emit) async{
   emit(AuthBlocLoading());
   Either<Failure, Unit> result;
  result = await logOutUseCase.call();
  result.fold((l) {
    ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Container(color: AppColors.red, child: const Text('error logging user out'),)));
      emit((AuthBlocError()));
   }, 
   (r) {
    ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Container(color: AppColors.green, child: const Text('user loggedOut successfully'),)));
    Navigator.pushReplacement(
      event.context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
    emit((AuthBlocSuccess()));
   });
  }

  FutureOr<void> _sendOTP(SendOTPEvent event, Emitter<AuthBlocState> emit) async{
    emit(AuthBlocLoading());
   Either<Failure, Unit> result;
  result = await sendOTPUseCase.call(event.phoneNumber);
  result.fold((l) {
    ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Container(color: AppColors.red, child: const Text('error sending otp'),)));
      emit((AuthBlocError()));
   }, 
   (r) {
    ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Container(color: AppColors.green, child: const Text('otp sent successfully'),)));
      emit((AuthBlocSuccess()));
   });
  }

  FutureOr<void> _verifyOTP(verifyOTPEvent event, Emitter<AuthBlocState> emit) async{
    emit(AuthBlocLoading());
   Either<Failure, Unit> result;
  result = await verifyOTPUseCase.call(event.verificationId, event.otpCode);
  result.fold((l) {
    ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Container(color: AppColors.red, child: const Text('error verifyiing otp'),)));
      emit((AuthBlocError()));
   }, 
   (r) {
    ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Container(color: AppColors.green, child: const Text('otp verified successfully'),)));
    emit((AuthBlocSuccess()));
   });
  }

  FutureOr<void> _loadUserData(LoadUserDataEvent event, Emitter<AuthBlocState> emit) async{
     emit(AuthBlocLoading());
   Either<Failure, UserEntity> result;
  result = await loadUserDataUseCase.call();
  result.fold((l) {
    ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Container(color: AppColors.red, child: const Text('error fetching user data'),)));
      emit((AuthBlocError()));
   }, 
   (r) {
    UserEntity entity = r;
    emit((AuthBlocSuccess()));
   });
  }
}
