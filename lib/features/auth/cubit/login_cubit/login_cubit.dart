import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial/features/auth/cubit/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState>
{
  LoginCubit() : super(InitialState());
  static LoginCubit get(context)=> BlocProvider.of(context);
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  bool passwordSecure = true;

  void changePasswordVisibility()
  {
    passwordSecure = !passwordSecure;
    emit(ChangePasswordState());
  }
  void login()
  {

  }


}
