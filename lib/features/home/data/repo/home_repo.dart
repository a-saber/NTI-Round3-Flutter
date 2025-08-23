import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tutorial/features/auth/data/models/user_model.dart';
import 'package:flutter_tutorial/features/home/data/models/task_model.dart';

class HomeRepo
{
  Future<Either<String, UserModel>> getUser()async
  {
    try{
      var userData = await FirebaseFirestore.instance.collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid).get();
      UserModel user = UserModel.fromJson(userData.data()!);
      return Right(user);
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
}

