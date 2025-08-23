import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial/core/helper/my_navigator.dart';
import 'package:flutter_tutorial/features/auth/data/models/user_model.dart';
import 'package:flutter_tutorial/features/auth/views/login_view.dart';
import 'package:flutter_tutorial/features/home/cubit/user_cubit/user_cubit.dart';
import 'package:flutter_tutorial/features/home/cubit/user_cubit/user_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, this.user});
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..controlUser(user),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<UserCubit, UserState>(
            builder: (context, state)
            {
              if(state is UserLoading)
              {
                return CircularProgressIndicator();
              }
              else if(state is UserError)
              {
                return Text(state.error);
              }
              else if(state is UserSuccess)
              {
                return Text(state.user.email);
              }
              else
              {
                return SizedBox();
              }
            }
          ),
          actions:
          [
            TextButton(onPressed: (){
              FirebaseAuth.instance.signOut();
              MyNavigator.goTo(context, LoginView(), type: NavigatorType.pushAndRemoveUntil);
              }, child: Text('Logout'))
          ],
        ),
      ),
    );
  }
}
