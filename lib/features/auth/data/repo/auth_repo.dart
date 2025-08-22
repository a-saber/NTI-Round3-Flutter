import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tutorial/features/auth/data/models/user_model.dart';

class AuthRepo{

  Future<Either<String, UserModel>> login({required String email, required String password}) async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      var userData = await FirebaseFirestore.instance.collection('users').doc(credential.user!.uid).get();
      UserModel user = UserModel.fromJson(userData.data()!);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return Left(e.code);
    }
    catch (e) {
      print(e);
      return Left(e.toString());
    }


  }

  Future<Either<String, UserModel>> register({required String name, required String email, required String password})async
  {
    try {
      // Authenticate User
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Add User to Database
      UserModel user = UserModel(id: credential.user!.uid,name: name, email: email);
      await FirebaseFirestore.instance.collection('users')
      .doc(user.id)
      .set(user.toJson());

      return Right(user);
      // TODO: Complete register with storage
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return Left(e.code);
    } catch (e) {
      print(e);
      return Left(e.toString());

    }
  }
}