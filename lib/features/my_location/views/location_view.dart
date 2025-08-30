import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../cubit/location_cubit/location_cubit.dart';
import '../cubit/location_cubit/location_state.dart';

class LocationView extends StatelessWidget {
  const LocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationCubit()..getLocation(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Location'),
        ),
        body: BlocBuilder<LocationCubit, LocationState>(
          builder: (context, state)
          {
            if(state is LocationLoading)
            {
              return Center(child: CircularProgressIndicator(),);
            }
            else if(state is LocationSuccess)
            {
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(state.position.latitude, state.position.longitude),
                  zoom: 5,
                ),
                markers: LocationCubit.get(context).markers,
              );
            }
            else if(state is LocationError)
            {
              return Text(state.message);
            }
            else
            {
              return SizedBox();
            }
          }
        ),
      ));
  }
}
