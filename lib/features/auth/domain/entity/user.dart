import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String role;
  final double latitude;
  final double longitude;

  const User({
    required this.latitude,
    required this.longitude,
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  @override
  List<Object?> get props => [id, name, email, role, latitude, longitude];
}
