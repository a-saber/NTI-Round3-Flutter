import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial/core/helper/my_navigator.dart';
import 'package:flutter_tutorial/features/auth/data/models/user_model.dart';
import 'package:flutter_tutorial/features/auth/views/login_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, this.user});
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user?.email??" default"),
        actions:
        [
          TextButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            MyNavigator.goTo(context, LoginView(), type: NavigatorType.pushAndRemoveUntil);
            }, child: Text('Logout'))
        ],
      ),
    );
  }
}
