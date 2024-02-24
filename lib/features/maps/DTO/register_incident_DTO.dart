import 'package:disaster_safety/models/map_enums.dart';

class RegisterIncidentDTO {
  final IncidentType incidentType;
  final IncidentPriority incidentPriority;
  final String description;
  final String imgPath;
  final String userId;
  final double longitude;
  final double latitude;
  final String state;

  RegisterIncidentDTO(
      {required this.incidentType,
      required this.state,
      required this.incidentPriority,
      required this.description,
      required this.imgPath,
      required this.userId,
      required this.longitude,
      required this.latitude});
}
