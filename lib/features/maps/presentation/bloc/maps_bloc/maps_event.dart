part of 'maps_bloc.dart';

sealed class MapsEvent extends Equatable {
  const MapsEvent();

  @override
  List<Object> get props => [];
}

class LoadMapsForUserEvent extends MapsEvent {
  final IncidentType incidentType;
  final IncidentPriority incidentPriority;
  final ResourceType resourceType;

  LoadMapsForUserEvent({
    required this.incidentType,
    required this.incidentPriority,
    required this.resourceType,
  });
}

class LoadMapsForAdminEvent extends MapsEvent {}

class RegisterDisasterEvent extends MapsEvent {
  final RegisterIncidentDTO dto;

  RegisterDisasterEvent({required this.dto});
}
