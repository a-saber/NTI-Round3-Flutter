import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tutorial/core/utils/app_assets.dart';
import 'package:flutter_tutorial/core/utils/app_paddings.dart';
import 'package:flutter_tutorial/core/widgets/custom_btn.dart';
import 'package:flutter_tutorial/core/widgets/custom_svg.dart';
import 'package:flutter_tutorial/core/widgets/custom_text_btn.dart';
import 'package:flutter_tutorial/core/widgets/custom_text_form_field.dart';
import 'package:flutter_tutorial/features/auth/cubit/login_cubit/login_cubit.dart';
import 'package:flutter_tutorial/features/auth/cubit/login_cubit/login_state.dart';

import 'register_view.dart';
import 'widgets/custom_auth_image.dart';
import 'widgets/custom_q_text.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: Scaffold(
        body: Builder(
          builder: (context) {
            return Column(
              children:
              [
                CustomAuthImage(),
                SizedBox(height: 23.h,),
                Padding(
                  padding: AppPaddings.horizontalPadding,
                  child: Column(
                    children:
                    [
                      CustomTextFormField(
                        controller: LoginCubit.get(context).usernameController,
                        prefixIcon: IconButton(
                            onPressed: null,
                            icon: CustomSvg(path: AppAssets.person)
                        ),
                        hintText: 'username',
                      ),
                      SizedBox(height: 10.h,),
                    BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, state) {
                        if (state is ChangePasswordVisibilityState) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Password Visibility Changed')));
                        }
                      },
                      builder:  (context, state)=> CustomTextFormField(
                        controller: LoginCubit.get(context).passwordController,
                        prefixIcon: IconButton(
                            onPressed:null,
                            icon: CustomSvg(path: AppAssets.key)
                        ),
                        hintText: 'password',
                        obscureText: LoginCubit.get(context).passwordSecure,
                        suffixIcon: IconButton(
                            onPressed:  LoginCubit.get(context).changePasswordVisibility,
                            icon: CustomSvg(path: LoginCubit.get(context).passwordSecure? AppAssets.lockIcon : AppAssets.unlockIcon)
                        ),
                      ),
                    ),

                      SizedBox(height: 23.h,),
                      CustomBtn(text: 'Login', onPressed: (){}),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          CustomQText(
                            text: 'Don\'t have an account?',
                          ),
                          SizedBox(width: 8.w,),
                          CustomTextBtn(text: 'Register', onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterView(),));
                          })

                        ],
                      )

                    ],
                  ),
                )
              ],
            );
          }
        ),

      ),
    );
  }
}
