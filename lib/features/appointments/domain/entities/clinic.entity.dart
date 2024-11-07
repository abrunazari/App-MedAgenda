import 'package:app_medagenda/features/appointments/domain/entities/category.entity.dart';

class ClinicEntity {
  final String id;
  final String name;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final DateTime? deactivatedAt;
  final String organizationId;
  final List<CategoryEntity> categories;

  ClinicEntity({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.deactivatedAt,
    required this.organizationId,
    this.categories = const [],
  });

  @override
  String toString() {
    return 'ClinicEntity(id: $id, name: $name, imageUrl: $imageUrl, createdAt: $createdAt, updatedAt: $updatedAt, categories: ${categories.length})';
  }

  factory ClinicEntity.fromJson(Map<String, dynamic> fullJson) {
    var clinicJson = fullJson['clinic'];

    var categoriesJson = fullJson['categories'] as List<dynamic>? ?? [];

    List<CategoryEntity> categories = categoriesJson.map((categoryJson) {
      return CategoryEntity.fromJson(categoryJson);
    }).toList();

    return ClinicEntity(
        id: clinicJson['id'] ?? 'default_id',
        name: clinicJson['name'] ?? 'No name provided',
        imageUrl: clinicJson['imageUrl'],
        organizationId:
            clinicJson['organizationId'] ?? 'default_organization_id',
        createdAt: clinicJson['createdAt'] != null
            ? DateTime.parse(clinicJson['createdAt'])
            : DateTime.now(),
        updatedAt: DateTime.parse(clinicJson['updatedAt']),
        deletedAt: clinicJson['deletedAt'] != null
            ? DateTime.parse(clinicJson['deletedAt'])
            : null,
        deactivatedAt: clinicJson['deactivatedAt'] != null
            ? DateTime.parse(clinicJson['deactivatedAt'])
            : null,
        categories: categories);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'deactivatedAt': deactivatedAt?.toIso8601String(),
      'organizationId': organizationId,
      'categories': categories.map((category) => category.toJson()).toList(),
    };
  }
}
