part of 'auth_bloc_bloc.dart';

sealed class AuthBlocEvent extends Equatable {
  const AuthBlocEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthBlocEvent {
  String mobile;
  String password;

  LoginEvent(this.mobile, this.password);
}

class RegisterEvent extends AuthBlocEvent {
  String email;
  String password;
  String phoneNumber;
  String fullName;
  int age;
  String gender;
  String mobileRegx;
  String passwordRegx;

  RegisterEvent({required this.age, required this.email, required this.fullName, required this.gender,
   required this.phoneNumber, required this.password, required this.mobileRegx, required this.passwordRegx});
}

class LogoutEvent extends AuthBlocEvent{

}

class SendOTPEvent extends AuthBlocEvent{
  String phoneNumber;

  SendOTPEvent(this.phoneNumber);
}

class verifyOTPEvent extends AuthBlocEvent{
  String verificationId;
  String otpCode;

  verifyOTPEvent({required this.otpCode, required this.verificationId});
}

class LoadUserDataEvent extends AuthBlocEvent{}