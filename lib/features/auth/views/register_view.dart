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
import 'package:flutter_tutorial/features/auth/cubit/register_cubit/register_cubit.dart';
import 'package:flutter_tutorial/features/auth/cubit/register_cubit/register_state.dart';
import 'widgets/custom_auth_image.dart';
import 'widgets/custom_q_text.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> RegisterCubit(),
      child: Scaffold(
        body: BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state)=> Column(
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
                      controller: RegisterCubit.get(context).usernameController,
                      prefixIcon: IconButton(
                          onPressed: null,
                          icon: CustomSvg(path: AppAssets.person)
                      ),
                      hintText: 'username',
                    ),
                    SizedBox(height: 10.h,),
                    CustomTextFormField(
                      controller: RegisterCubit.get(context).passwordController,
                      prefixIcon: IconButton(
                          onPressed:null,
                          icon: CustomSvg(path: AppAssets.key)
                      ),
                      hintText: 'password',
                      obscureText: RegisterCubit.get(context).passwordSecure,
                      suffixIcon: IconButton(
                          onPressed:  RegisterCubit.get(context).changePasswordVisibility,
                          icon: CustomSvg(path: RegisterCubit.get(context).passwordSecure? AppAssets.lockIcon : AppAssets.unlockIcon)
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    CustomTextFormField(
                      controller: RegisterCubit.get(context).confirmPasswordController,
                      prefixIcon: IconButton(
                          onPressed:null,
                          icon: CustomSvg(path: AppAssets.key)
                      ),
                      hintText: 'confirm password',
                      obscureText: RegisterCubit.get(context).confirmPasswordSecure,
                      suffixIcon: IconButton(
                          onPressed:  RegisterCubit.get(context).changeConfirmPasswordVisibility,
                          icon: CustomSvg(path: RegisterCubit.get(context).confirmPasswordSecure? AppAssets.lockIcon : AppAssets.unlockIcon)
                      ),
                    ),
                    SizedBox(height: 23.h,),
                    CustomBtn(text: 'Register', onPressed: (){}),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        CustomQText(
                          text: 'Already have an account?',
                        ),
                        SizedBox(width: 8.w,),
                        CustomTextBtn(text: 'Login', onPressed: (){})

                      ],
                    )

                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
