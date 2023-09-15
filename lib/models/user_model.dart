class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? role;
  final double latitude;
  final double longitude;

  UserModel({
    required this.latitude,
    required this.longitude,
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['uid'],
        name: json['name'],
        email: json['useremail'],
        role: json['role'],
        latitude: json['latitude'] ?? 0,
        longitude: json['longitude'] ?? 0);
  }
}
