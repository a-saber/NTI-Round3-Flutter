import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tutorial/core/network/api_helper.dart';
import 'package:flutter_tutorial/core/network/api_response.dart';
import 'package:flutter_tutorial/core/network/end_points.dart';
import 'package:flutter_tutorial/features/auth/data/models/user_model.dart';
import 'package:flutter_tutorial/features/home/data/models/menu_response_model.dart';
import 'package:flutter_tutorial/features/home/data/models/task_model.dart';

import '../../../auth/data/models/login_response_model.dart';

class HomeRepo
{
  ApiHelper apiHelper = ApiHelper();
  Future<Either<String, UserModel>> getUser()async
  {
    try{
      var response = await apiHelper.getRequest(
        endPoint: EndPoints.getUserData,
        isProtected: true
      );
      if(response.status)
      {
        var data = response.data as Map<String, dynamic>;
        LoginResponseModel responseModel =
        LoginResponseModel.fromJson(data);
        return right(responseModel.user!);
      }
      else{
        return Left(response.message);
      }
    }
    catch(e)
    {
      return Left(e.toString());
    }
  }
  
  Future<Either<String, List<TaskModel>>> getTasks() async
  {
    try
    {
      var response= await FirebaseFirestore.instance.collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid).collection('tasks')
          .get();
      var tasks =  response.docs.map((e) => TaskModel.fromJson(e.data())).toList();
      return Right(tasks);
    }
    catch(e)
    {
      return Left(e.toString());
    }
  }


  Future<Either<String, List<CategoryModel>>> getMenu() async
  {
    try
    {
      var response = await apiHelper.getRequest(
        endPoint: EndPoints.getMenu,
        isProtected: true
      );
      if(response.status)
      {
        MenuResponseModel menu = MenuResponseModel.fromJson(response.data as Map<String, dynamic>);
        return Right(menu.categories!);
      }
      else
      {
        return Left(response.message);
      }
    }
    catch(e)
    {
      return Left(ApiResponse.fromError(e).message);
    }
  }
}

