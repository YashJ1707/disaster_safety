// To parse this JSON data, do
//
//     final incident = incidentFromJson(jsonString);

import 'dart:convert';

Incident incidentFromJson(String str) => Incident.fromJson(json.decode(str));

String incidentToJson(Incident data) => json.encode(data.toJson());

class Incident {
  String id;
  String incidentType;
  String incidentPriority;
  DateTime reportedDate;
  double longitude;
  double latitude;
  String description;
  String reportedBy;
  bool isApproved;
  String? approvedBy;
  bool isOpen;

  Incident(this.approvedBy,
      {required this.id,
      required this.incidentType,
      required this.incidentPriority,
      required this.reportedDate,
      required this.longitude,
      required this.latitude,
      required this.description,
      required this.reportedBy,
      required this.isApproved,
      required this.isOpen});

  factory Incident.fromJson(Map<String, dynamic> json) =>
      Incident(json["approved_by"],
          id: json['id'],
          incidentType: json["incident_type"],
          incidentPriority: json["incident_priority"],
          reportedDate: DateTime.parse(json["reported_date"]),
          longitude: json["longitude"],
          latitude: json["latitude"],
          description: json["description"],
          reportedBy: json["reported_by"],
          isApproved: json["is_approved"],
          isOpen: json['is_open']);

  Map<String, dynamic> toJson() => {
        'id': id,
        "incident_type": incidentType,
        "incident_priority": incidentPriority,
        "reported_date": reportedDate.toIso8601String(),
        "longitude": longitude,
        "latitude": latitude,
        "description": description,
        "reported_by": reportedBy,
        "is_approved": isApproved,
        "approved_by": approvedBy,
        "is_open": isOpen,
      };
}
