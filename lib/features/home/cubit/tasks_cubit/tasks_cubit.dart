import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial/features/home/cubit/tasks_cubit/tasks_state.dart';
import 'package:flutter_tutorial/features/home/data/models/task_model.dart';
import 'package:flutter_tutorial/features/home/data/repo/home_repo.dart';

class TasksCubit extends Cubit<TasksState>
{
  TasksCubit() : super(TasksInitial());
  static TasksCubit get(context)=> BlocProvider.of(context);
  getTasks()async
  {
    HomeRepo homeRepo = HomeRepo();
    emit(TasksLoading());
    var response = await homeRepo.getTasks();
    response.fold(
        (error)=> emit(TasksError(error: error)),
        (tasks)=> emit(TasksSuccess(tasks: tasks))
    );

  }
}