class IncidentModel {
  String? id;
  double lat;
  double long;
  DateTime time;
  IncidentPriority priority;
  IncidentType incidentType;
  String userId;

  IncidentModel(
      {this.id,
      required this.lat,
      required this.long,
      required this.time,
      required this.priority,
      required this.incidentType,
      required this.userId});
}

enum IncidentType {
  accident,
  flood,
  landslide,
  forestFire,
  earthquake,
  tornado,
  hurricane,
  tsunami,
  drought,
  avalanche,
}

enum IncidentPriority { low, moderate, high }
