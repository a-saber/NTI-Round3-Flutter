import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tutorial/core/utils/app_colors.dart';
import 'package:flutter_tutorial/core/utils/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key, required this.controller,
    required this.prefixIcon, this.suffixIcon, required this.hintText,
    this.obscureText = false});

  final TextEditingController controller ;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
        color: AppColors.black,
        fontSize: 14.sp,
        fontWeight: AppFontWeight.light
      ),
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyle(
          fontWeight: AppFontWeight.extraLight,
          fontSize: 14.sp,
          color: AppColors.grey
        ),
        border: borderBuilder(),
        enabledBorder: borderBuilder(),
        focusedBorder: borderBuilder(color: AppColors.primary),
        focusedErrorBorder: borderBuilder(color: AppColors.primary),
        errorBorder: borderBuilder(color: AppColors.red),


      ),
    );
  }

  InputBorder borderBuilder({Color color = AppColors.lightGrey})=>OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.r),
      borderSide: BorderSide(
          color: color
      )
  );
}
