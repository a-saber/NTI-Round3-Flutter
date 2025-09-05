import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tutorial/core/network/api_helper.dart';
import 'package:flutter_tutorial/core/network/api_response.dart';
import 'package:flutter_tutorial/core/network/end_points.dart';
import 'package:flutter_tutorial/features/auth/data/models/login_response_model.dart';
import 'package:flutter_tutorial/features/auth/data/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo{
  ApiHelper apiHelper = ApiHelper();
  Future<Either<String, UserModel>> login({
    required String email, required String password})
  async{
    try {
      var response = await apiHelper.postRequest(
        endPoint: EndPoints.login,
        data: {
          'email': email,
          'password': password
        }
      );
      if(response.status)
      {
        LoginResponseModel loginResponseModel
        = LoginResponseModel.fromJson(response.data as Map<String, dynamic>);

        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('access_token', loginResponseModel.accessToken!);
        sharedPreferences.setString('refresh_token', loginResponseModel.refreshToken!);

        return Right(loginResponseModel.user!);
      }
      else{
        return Left(response.message);
      }

    }
    catch (e) {
      print(e);
      return Left(ApiResponse.fromError(e).message);

    }


  }

  Future<Either<String, Unit>> register({
    required String phone,
    required String name,
    required String email,
    required String password,
    XFile? image
  })async
  {
    try {
      final Map<String, dynamic> data = {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      };

      // If image exists, attach as file
      if (image != null) {
        data['image'] = await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        );
      }
      var response = await apiHelper.postRequest(
        endPoint: EndPoints.register,
        data: data
      );
      if(response.status)
      {
        return right(unit);
      }
      else
      {
        return left(response.message);
      }
    }
    catch (e) {
      print(e);
      return Left(ApiResponse.fromError(e).message);

    }
  }

  // Future<Either<String, UserModel>> login({required String email, required String password}) async{
  //   try {
  //     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: email,
  //         password: password
  //     );
  //     var userData = await FirebaseFirestore.instance.collection('users').doc(credential.user!.uid).get();
  //     UserModel user = UserModel.fromJson(userData.data()!);
  //     return Right(user);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //     }
  //     return Left(e.code);
  //   }
  //   catch (e) {
  //     print(e);
  //     return Left(e.toString());
  //   }
  //
  //
  // }
  //
  // Future<Either<String, UserModel>> register({required String name, required String email, required String password})async
  // {
  //   try {
  //     // Authenticate User
  //     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //
  //     // Add User to Database
  //     UserModel user = UserModel(id: credential.user!.uid,name: name, email: email);
  //     await FirebaseFirestore.instance.collection('users')
  //     .doc(user.id)
  //     .set(user.toJson());
  //
  //     return Right(user);
  //     // TODO: Complete register with storage
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     }
  //     return Left(e.code);
  //   } catch (e) {
  //     print(e);
  //     return Left(e.toString());
  //
  //   }
  // }
}