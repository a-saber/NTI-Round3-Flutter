
import 'package:flutter_tutorial/features/home/data/models/menu_response_model.dart';

abstract class MenuState {}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuError extends MenuState {
  final String error;
  MenuError({required this.error});
}

class MenuSuccess extends MenuState {
  final List<CategoryModel> categories;
  MenuSuccess({required this.categories});
}