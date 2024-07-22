import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ps_task/core/theme/app_colors.dart';
import 'package:ps_task/core/theme/app_fonts.dart';
import 'package:ps_task/core/theme/app_icons.dart';
import 'package:ps_task/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _selectedGender = 'Male'; // Default gender selection
  bool _isLoading = false;

  // Sample regex patterns
  String mobileRegex = r'^\+?[1-9]\d{1,14}$'; // Sample regex for mobile number
  String passwordRegex =
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$'; // Sample regex for password

  Future<void> _register() async {
    AuthBlocBloc.get(context).add(RegisterEvent(context, age: int.parse(_ageController.text), email: _mobileController.text, fullName: _fullNameController.text, gender: _selectedGender, phoneNumber: _mobileController.text, password: _passwordController.text, mobileRegx: mobileRegex, passwordRegx: passwordRegex));
   /* if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _mobileController.text,
          password: _passwordController.text,
        );

        // Save user information in Firestore
        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'full_name': _fullNameController.text,
          'mobile': _mobileController.text,
          'age': int.parse(_ageController.text),
          'gender': _selectedGender,
        });

        setState(() {
          _isLoading = false;
        });

        // Show success message
        mounted?ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Container(
            color: AppColors.green,
            child: const Text('Registration successful!'))),
        ):null;

        // Navigate to login screen
        mounted?Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        ):null;
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoading = false;
        });
        _showErrorDialog('Error: ${e.message}');
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        _showErrorDialog('Error: ${e.toString()}');
      }
    }*/
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  AppIcons.ps_logo,
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _mobileController,
                  decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    } else if (!RegExp(mobileRegex).hasMatch(value)) {
                      return 'Please enter a valid mobile number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Male', 'Female'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGender = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (!RegExp(passwordRegex).hasMatch(value)) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _isLoading ? null : _register,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.white, 
                    backgroundColor: AppColors.primary_1,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: AppFonts.seezBold20,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AppColors.white),
                        )
                      : const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
