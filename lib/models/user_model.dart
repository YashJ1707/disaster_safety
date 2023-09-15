class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? role;
  final double latitude;
  final double longitude;

  UserModel(
      {required this.latitude,
      required this.longitude,
      required this.id,
      required this.name,
      required this.email,
      required this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        role: json['role'],
        latitude: json['latitude'],
        longitude: json['longitude']);
  }
}


// usages
