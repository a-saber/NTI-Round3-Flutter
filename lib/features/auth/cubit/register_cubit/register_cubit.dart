import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState>
{
  RegisterCubit(): super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

  var usernameController = TextEditingController();
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

}