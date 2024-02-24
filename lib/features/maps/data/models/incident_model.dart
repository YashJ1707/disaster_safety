// To parse this JSON data, do
//
//     final incident = incidentFromJson(jsonString);

import 'dart:convert';

import '../../../../models/map_enums.dart';

IncidentModel incidentFromJson(String str) =>
    IncidentModel.fromJson(json.decode(str));

String incidentToJson(IncidentModel data) => json.encode(data.toJson());

class IncidentModel {
  String id;
  IncidentType incidentType;
  IncidentPriority incidentPriority;
  DateTime reportedDate;
  double longitude;
  double latitude;
  String description;
  String reportedBy;
  bool isApproved;
  String? approvedBy;
  String? imgpath;
  bool isOpen;
  DateTime? closureDate;
  String state;
  String geohash;

  IncidentModel(this.approvedBy,
      {required this.geohash,
      required this.id,
      required this.incidentType,
      required this.incidentPriority,
      required this.reportedDate,
      required this.longitude,
      required this.latitude,
      required this.description,
      required this.reportedBy,
      required this.isApproved,
      required this.imgpath,
      required this.isOpen,
      required this.closureDate,
      required this.state});

  factory IncidentModel.fromJson(Map<String, dynamic> json) =>
      IncidentModel(json["approved_by"],
          geohash: json['geohash'],
          id: json['id'],
          incidentType: json["incident_type"],
          incidentPriority: json["incident_priority"],
          reportedDate: DateTime.parse(json["reported_date"]),
          longitude: json["longitude"],
          latitude: json["latitude"],
          description: json["description"],
          reportedBy: json["reported_by"],
          isApproved: json["is_approved"],
          imgpath: json["imgpath"],
          isOpen: json['is_open'],
          closureDate: json["closure_date"],
          state: json["state"]);

  Map<String, dynamic> toJson() => {
        'id': id,
        "geohash": geohash,
        "incident_type": incidentType,
        "incident_priority": incidentPriority,
        "reported_date": reportedDate.toIso8601String(),
        "longitude": longitude,
        "latitude": latitude,
        "description": description,
        "reported_by": reportedBy,
        "is_approved": isApproved,
        "approved_by": approvedBy,
        "imgpath": imgpath,
        "is_open": isOpen,
        "closure_date": closureDate,
        "state": state,
      };
}
