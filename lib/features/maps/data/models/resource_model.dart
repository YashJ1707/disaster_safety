import 'dart:convert';

import 'package:disaster_safety/models/map_enums.dart';

ResourceModel resourceFromJson(String str) =>
    ResourceModel.fromJson(json.decode(str));

String resourceToJson(ResourceModel data) => json.encode(data.toJson());

class ResourceModel {
  String id;
  String name;
  ResourceType resourceType;
  String description;
  double longitude;
  double latitude;
  String geohash;

  ResourceModel({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.id,
    required this.resourceType,
    required this.description,
    required this.geohash,
  });

  factory ResourceModel.fromJson(Map<String, dynamic> json) => ResourceModel(
      id: json["id"],
      name: json["name"],
      resourceType: json["resource_type"],
      description: json["description"],
      latitude: json['latitude'],
      longitude: json['longitude'],
      geohash: json['geohash']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "resource_type": resourceType,
        "description": description,
        "longitude": longitude,
        "latitude": latitude,
        "geohash": geohash,
      };
}
