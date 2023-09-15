class AlertModel {
  final int id;
  final String title;
  final String subtitle;
  final String tag;

  AlertModel(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.tag});

  factory AlertModel.fromJson(Map<String, dynamic> json) {
    return AlertModel(
        id: json['id'],
        title: json['title'],
        subtitle: json['subtitle'],
        tag: json['tag']);
  }
  // AlertModel(this.id, this.title, this.subtitle, this.tag);
}


// usages
