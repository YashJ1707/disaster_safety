class UserModel {
  int? id;
  String name;
  String email;
  String lat;
  String long;
  String? role;

  UserModel(
      {this.id,
      required this.name,
      required this.email,
      required this.lat,
      required this.long,
      required this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      lat: json['lat'],
      long: json['long'],
    );
  }
}


// usages
