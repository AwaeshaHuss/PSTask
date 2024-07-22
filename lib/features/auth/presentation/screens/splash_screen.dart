import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ps_task/core/theme/app_colors.dart';
import 'package:ps_task/core/theme/app_fonts.dart';
import 'package:ps_task/core/theme/app_icons.dart';
import 'package:ps_task/features/auth/presentation/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadConfigAndNavigate();
  }

  Future<void> _loadConfigAndNavigate() async {
    await Future.delayed(const Duration(seconds: 2));

    try {
      DocumentSnapshot config = await FirebaseFirestore.instance.collection('config').doc('system').get();
      log('Config data: ${config.data()}');
    } catch (e) {
      log('Error loading config: $e');
    }
    mounted ?Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    ):null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              AppIcons.ps_logo,
              width: 200,
              height: 200,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '© 2024 ProgressSoft',
                style: AppFonts.seezBlack18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}