import 'package:bloc/bloc.dart';
import 'package:disaster_safety/features/maps/DTO/register_incident_DTO.dart';
import 'package:equatable/equatable.dart';

part 'maps_event.dart';
part 'maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  MapsBloc() : super(MapsInitial()) {
    on<MapsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
