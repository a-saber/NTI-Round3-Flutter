import '../../data/models/task_model.dart';

abstract class TasksState {}

class TasksInitial extends TasksState {}

class TasksLoading extends TasksState {}

class TasksError extends TasksState {
  final String error;
  TasksError({required this.error});
}

class TasksSuccess extends TasksState {
  final List<TaskModel> tasks;
  TasksSuccess({required this.tasks});
}