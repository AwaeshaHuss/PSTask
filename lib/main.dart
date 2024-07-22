import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ps_task/config/bloc_providers.dart';
import 'package:ps_task/config/injection.dart' as di;
import 'package:ps_task/core/theme/app_themes.dart';
import 'package:ps_task/core/utils.dart';
import 'package:ps_task/features/auth/presentation/screens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.DependencyInjection.init();
  runApp(const MyApp());
  Bloc.observer = PSTaskBlocObserver();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return blocProviders(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PS_Task',
        theme: AppTheme.lightMode,
        home: SplashScreen(),
      ),
    );
  }
}
