import 'dart:convert';

Resource resourceFromJson(String str) => Resource.fromJson(json.decode(str));

String resourceToJson(Resource data) => json.encode(data.toJson());

class Resource {
  String id;
  String resourceType;
  String description;

  Resource({
    required this.id,
    required this.resourceType,
    required this.description,
  });

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
        id: json["id"],
        resourceType: json["resource_type"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "resource_type": resourceType,
        "description": description,
      };
}
