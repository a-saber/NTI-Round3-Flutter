
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/utils/app_colors.dart';
import 'features/auth/views/login_view.dart';
import 'features/auth/views/register_view.dart';


void main()
{
  runApp(MyApp());
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
        home: RegisterView(),
      ),
    );
  }
}

