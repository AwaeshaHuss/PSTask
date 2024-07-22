import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:ps_task/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


abstract class AuthRemoteDataSource{
  Future<Unit> login(String mobile, String password);
  Future<Unit> register(String email, String password, String phoneNumber, String fullName, int age, String gender, String mobileRegx, String passwordRegx);
  Future<Unit> sendOTP(String phoneNumber);
  Future<Unit> verifyOTP(String verificationId, String otpCode);
  Future<Unit> logout();
  Future<UserModel> loadUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSourceImpl(this._firebaseAuth, this._firestore);

  @override
  Future<Unit> login(String mobile, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: mobile, password: password);
      DocumentSnapshot userDoc = await _firestore.collection('Users').doc(userCredential.user?.uid).get();

      if (userDoc.exists) {
        // Save credentials for auto-login and navigate to home screen
        return unit;
      } else {
        // Show dialog with "Cancel" and "Register" options
        return unit;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        // Show error message
      } else if (e.code == 'user-not-found') {
        // Show dialog with "Cancel" and "Register" options
      }
      return Future.error(e);
    }
  }

  @override
  Future<Unit> register(String email, String password, String phoneNumber, String fullName, int age, String gender, String mobileRegx, String passwordRegx) async {
    try {
      await sendOTP(phoneNumber);

      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      UserModel userModel = UserModel(id: userCredential.user?.uid ?? '', email: email, mobileNumber: phoneNumber, fullName: fullName, age: age, gender: gender, mobileRegx: mobileRegx, passwordRegx: passwordRegx);

      await _firestore.collection('Users').doc(userCredential.user?.uid).set(userModel.toJson());

      return unit;
    } on FirebaseAuthException catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<Unit> sendOTP(String phoneNumber) async {
     try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          throw e;
        },
        codeSent: (String verificationId, int? resendToken) {
          log("Code sent to $phoneNumber. Verification ID: $verificationId");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          log("Auto retrieval timeout. Verification ID: $verificationId");
        },
      );
      return unit;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<Unit> verifyOTP(String verificationId, String otpCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCode,
      );
      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.user != null) {
        return unit;
      } else {
        return Future.error('Invalid OTP');
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<Unit> logout() async {
    await _firebaseAuth.signOut();
    return unit;
  }

  @override
  Future<UserModel> loadUserData() async {
    String uid = _firebaseAuth.currentUser?.uid ?? '';
    DocumentSnapshot userDoc = await _firestore.collection('Users').doc(uid).get();
    return UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
  }
}