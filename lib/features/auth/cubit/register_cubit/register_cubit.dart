import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial/features/auth/data/repo/auth_repo.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState>
{
  RegisterCubit(): super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  bool passwordSecure = true;
  bool confirmPasswordSecure = true;

  void changePasswordVisibility()
  {
    passwordSecure = !passwordSecure;
    emit(RegisterChangePasswordVisibility());
  }
  void changeConfirmPasswordVisibility()
  {
    confirmPasswordSecure = !confirmPasswordSecure;
    emit(RegisterChangeConfirmPasswordVisibility());
  }

  onRegisterPressed()async
  {
    emit(RegisterLoading());
    AuthRepo auth = AuthRepo();
    bool result = await auth.register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text
    );
    if(result){
      emit(RegisterSuccess());
    }
    else
    {
      emit(RegisterError(error: 'An error occurred'));
    }


  }
}