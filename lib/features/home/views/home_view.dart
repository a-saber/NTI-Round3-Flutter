import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial/core/helper/my_navigator.dart';
import 'package:flutter_tutorial/features/auth/data/models/user_model.dart';
import 'package:flutter_tutorial/features/auth/views/login_view.dart';
import 'package:flutter_tutorial/features/home/cubit/tasks_cubit/tasks_cubit.dart';
import 'package:flutter_tutorial/features/home/cubit/user_cubit/user_cubit.dart';
import 'package:flutter_tutorial/features/home/cubit/user_cubit/user_state.dart';
import 'package:flutter_tutorial/features/home/data/models/task_model.dart';

import '../cubit/tasks_cubit/tasks_state.dart';

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
              }, child: Text('Logout')
            ),
          ],
        ),
        body: BlocProvider(
          create: (context) => TasksCubit()..getTasks(),
          child: BlocBuilder<TasksCubit, TasksState>(
            builder: (context, state)
            {
              if(state is TasksLoading)
              {
                return Center(child: CircularProgressIndicator());
              }
              else if(state is TasksError)
              {
                return Center(child: Text(state.error));
              }
              else if(state is TasksSuccess)
              {
                return RefreshIndicator(
                  onRefresh: ()async
                  {
                    TasksCubit.get(context).getTasks();
                  },
                  child: ListView.builder(
                    itemBuilder: (context, index)=> Column(
                      children:
                      [
                        Text(state.tasks[index].title??'-'),
                        Text(state.tasks[index].description??'-'),
                      ],
                    ),
                    itemCount: state.tasks.length,
                  ),
                );
              }
              else {
                return SizedBox();
              }
            }
          ),
        ),
      ),
    );
  }
}
class HomeStreamView extends StatelessWidget {
  const HomeStreamView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid).collection('tasks')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              TaskModel task = TaskModel.fromJson(document.data()! as Map<String, dynamic>);
              return ListTile(
                title: Text(task.title??'-'),
                subtitle: Text(task.description??'-'),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}