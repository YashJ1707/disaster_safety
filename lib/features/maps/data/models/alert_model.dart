class AlertModel {
  final String? id;
  final String title;
  final String subtitle;
  final String tag;
  final double latitude;
  final double longitude;

  AlertModel(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.tag,
      required this.latitude,
      required this.longitude});

  factory AlertModel.fromJson(Map<String, dynamic> json) {
    return AlertModel(
        id: json['id'],
        title: json['title'],
        subtitle: json['subtitle'],
        tag: json['tag'],
        latitude: json['latitude'],
        longitude: json['longitude']);
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        "title": title,
        "subtitle": subtitle,
        "tag": tag,
        "latitude": latitude,
        "longitude": longitude,
      };
}
