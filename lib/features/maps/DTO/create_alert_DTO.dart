class CreateAlertDTO {
  final String title;
  final String subtitle;
  final String tag;
  final double latitude;
  final double longitude;

  CreateAlertDTO({
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.latitude,
    required this.longitude,
  });
}
