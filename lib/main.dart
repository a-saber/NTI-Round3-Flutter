
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/utils/app_colors.dart';
import 'features/auth/views/login_view.dart';


import 'package:firebase_core/firebase_core.dart';
import 'features/home/views/home_view.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
  FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
}


class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder:  (context , child)=>MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          fontFamily: 'Lexend_Deca'
        ),
        // home: FirebaseAuth.instance.currentUser == null ? const LoginView() : const HomeView(),
        home: FirebaseAuth.instance.currentUser == null ? const LoginView() : const HomeStreamView(),
      ),
    );
  }
}


