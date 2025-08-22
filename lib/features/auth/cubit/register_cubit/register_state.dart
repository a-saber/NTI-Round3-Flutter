import 'package:flutter_tutorial/features/auth/data/models/user_model.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterChangePasswordVisibility extends RegisterState {}
class RegisterChangeConfirmPasswordVisibility extends RegisterState {}

class RegisterLoading extends RegisterState {}
class RegisterSuccess extends RegisterState {
  UserModel userModel;
  RegisterSuccess({required this.userModel});
}
class RegisterError extends RegisterState {
  String error;
  RegisterError({required this.error});
}