import 'dart:convert';

Resource resourceFromJson(String str) => Resource.fromJson(json.decode(str));

String resourceToJson(Resource data) => json.encode(data.toJson());

class Resource {
  String resourceType;
  String description;

  Resource({
    required this.resourceType,
    required this.description,
  });

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
        resourceType: json["resource_type"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "resource_type": resourceType,
        "description": description,
      };
}
