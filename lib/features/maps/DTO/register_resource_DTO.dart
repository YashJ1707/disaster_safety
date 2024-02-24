import 'package:disaster_safety/models/map_enums.dart';

class RegisterResourceDTO {
  final ResourceType resourceType;
  final String name;
  final String description;
  final double latitude;
  final double longitude;

  RegisterResourceDTO(
      {required this.resourceType,
      required this.name,
      required this.description,
      required this.latitude,
      required this.longitude});
}
