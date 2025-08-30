import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tutorial/features/my_location/cubit/location_cubit/location_state.dart';
import 'package:flutter_tutorial/features/my_location/data/repo/location_repo.dart';

class LocationCubit extends Cubit<LocationState>
{
  LocationCubit() : super(LocationInitial());
  static LocationCubit get(context) => BlocProvider.of(context);

  getLocation()async
  {
    LocationRepo repo = LocationRepo();
    emit(LocationLoading());
    var response = await repo.getLocation();
    response.fold(
        (String error) => emit(LocationError( error)),
        (position) => emit(LocationSuccess( position))
    );
  }
}