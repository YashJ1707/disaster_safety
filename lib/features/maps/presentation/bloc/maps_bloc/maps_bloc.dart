import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:disaster_safety/features/maps/DTO/register_incident_DTO.dart';
import 'package:disaster_safety/features/maps/data/datasource/maps_datasource.dart';
import 'package:disaster_safety/features/maps/data/models/incident_model.dart';
import 'package:disaster_safety/features/maps/data/models/resource_model.dart';
import 'package:disaster_safety/features/maps/data/repository/alert_repository_impl.dart';
import 'package:disaster_safety/features/maps/data/repository/incident_repository_impl.dart';
import 'package:disaster_safety/features/maps/data/repository/resource_repository_impl.dart';
import 'package:disaster_safety/models/map_enums.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'maps_event.dart';
part 'maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  final MapsDatasourceImpl mapsDatasource;
  final AlertRepositoryImpl alertRepository;
  final IncidentRepositoryImpl incidentRepository;
  final ResourceRepositoryImpl resourceRepository;

  MapsBloc(
      {required this.mapsDatasource,
      required this.alertRepository,
      required this.incidentRepository,
      required this.resourceRepository})
      : super(MapsInitial()) {
    on<LoadMapsForUserEvent>((event, emit) async {
      emit(MapsLoadingState());

      LatLng currentLocation;

      //get user location
      final position = await mapsDatasource.determinePosition();
      currentLocation = LatLng(position.latitude, position.longitude);

      //get all map markers using nearby incidents
      //create a marker of current location
      Marker currentLocationMarker = Marker(
          markerId: const MarkerId("Your location"),
          position: currentLocation,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan));

      //get incidents and resources

      late List<IncidentModel> incidents;

      (await incidentRepository.getIncidentsForUser(
              longitude: currentLocation.longitude,
              latitude: currentLocation.latitude,
              radius: 5))
          .fold((l) => emit(MapsFailureState(message: (l.message))),
              (r) => incidents = r);

      late List<ResourceModel> resources;

      (await resourceRepository.getNearbyResources(
              longitude: currentLocation.longitude,
              latitude: currentLocation.latitude,
              radius: 5))
          .fold((l) => emit(MapsFailureState(message: (l.message))),
              (r) => resources = r);
      ;

      //add markers for all the incidents and resources

      final markers = await mapsDatasource.getMarkers(incidents, resources,
          event.incidentType, event.incidentPriority, event.resourceType);

      markers.add(currentLocationMarker);

      emit(MapsLoadedState());
    });

    on<RegisterDisasterEvent>((event, emit) async {
      emit(MapsLoadingState());

      (await incidentRepository.registerIncident(dto: event.dto)).fold(
          (l) => emit(MapsFailureState(message: (l.message))), (r) => null);

      emit(MapsInitial());
    });
  }
}
