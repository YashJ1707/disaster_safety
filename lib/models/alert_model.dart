class Alert {
  final String id;
  final String title;
  final String subtitle;
  final String tag;

  Alert(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.tag});

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
        id: json['id'],
        title: json['title'],
        subtitle: json['subtitle'],
        tag: json['tag']);
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        "title": title,
        "subtitle": subtitle,
        "tag": tag,
      };
  // Alert(this.id, this.title, this.subtitle, this.tag);
}


// usages
