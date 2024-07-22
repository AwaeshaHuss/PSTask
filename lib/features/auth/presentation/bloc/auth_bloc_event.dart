part of 'auth_bloc_bloc.dart';

sealed class AuthBlocEvent extends Equatable {
  const AuthBlocEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthBlocEvent {
  final BuildContext context;
  String mobile;
  String password;

  LoginEvent(this.mobile, this.password, this.context);
}

class RegisterEvent extends AuthBlocEvent {
  final BuildContext context;
  String email;
  String password;
  String phoneNumber;
  String fullName;
  int age;
  String gender;
  String mobileRegx;
  String passwordRegx;

  RegisterEvent(this.context, {required this.age, required this.email, required this.fullName, required this.gender,
   required this.phoneNumber, required this.password, required this.mobileRegx, required this.passwordRegx});
}

class LogoutEvent extends AuthBlocEvent{
  final BuildContext context;

  const LogoutEvent(this.context);
}

class SendOTPEvent extends AuthBlocEvent{
  final BuildContext context;
  String phoneNumber;

  SendOTPEvent(this.phoneNumber, this.context);
}

class verifyOTPEvent extends AuthBlocEvent{
  final BuildContext context;
  String verificationId;
  String otpCode;

  verifyOTPEvent(this.context, {required this.otpCode, required this.verificationId});
}

class LoadUserDataEvent extends AuthBlocEvent{
  final BuildContext context;

  const LoadUserDataEvent(this.context);
}