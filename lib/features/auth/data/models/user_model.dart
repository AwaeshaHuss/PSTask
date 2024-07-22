import 'package:ps_task/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  const UserModel({required super.email, required super.id, required super.fullName, required super.mobileNumber, required super.age, required super.gender, required super.mobileRegx, required super.passwordRegx});

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(id: json['id'], fullName: json['fullName'], mobileNumber: json['mobileNumber'], email: json['email'], age: json['age'], gender: json['gender'], mobileRegx: json['mobileRegx'], passwordRegx: json['passwordRegx']);
  }

  Map<String, dynamic> toJson(){
    return {
      'fullName': fullName,
      'mobileNumber': mobileNumber,
      'age': age,
      'gender': gender
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      email: email,
      id: id,
      fullName: fullName,
      mobileNumber: mobileNumber,
      age: age,
      gender: gender,
      mobileRegx: mobileRegx,
      passwordRegx: passwordRegx,
    );
  }
}