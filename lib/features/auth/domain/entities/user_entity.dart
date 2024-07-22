import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{
  final String? id;
  final String email;
  final String fullName;
  final String mobileNumber;
  final int age;
  final String gender;
  final String? mobileRegx;
  final String? passwordRegx;

  const UserEntity({required this.email, required this.id, required this.fullName, required this.mobileNumber, required this.age, required this.gender, required this.mobileRegx, required this.passwordRegx});
  
  @override
  List<Object?> get props => [
    fullName, mobileNumber, age, gender
  ];
  
}