import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tutorial/features/auth/data/models/user_model.dart';

class AuthRepo{

  Future<UserModel> login({required String email, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  Future<bool> register({required String name, required String email, required String password})async
  {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
      // TODO: Complete register with storage
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return false;
    } catch (e) {
      print(e);
      return false;

    }
  }
}