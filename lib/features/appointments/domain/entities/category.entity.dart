import 'package:app_medagenda/features/appointments/domain/entities/consult.entity.dart';

class CategoryEntity {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String clinicId;
  final List<ConsultEntity> consults;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.clinicId,
    this.consults = const [],
  });

  @override
  String toString() {
    return 'CategoryEntity(id: $id, name: $name, consults: ${consults.length})';
  }

  factory CategoryEntity.fromJson(Map<String, dynamic> fullJson) {
    var consultsJson = fullJson['consults'] as List<dynamic>? ?? [];

    List<ConsultEntity> consults = consultsJson.map((consultJson) {
      return ConsultEntity.fromJson(consultJson);
    }).toList();

    return CategoryEntity(
      id: fullJson['id'],
      name: fullJson['name'],
      createdAt: DateTime.parse(fullJson['createdAt']),
      updatedAt: DateTime.parse(fullJson['updatedAt']),
      deletedAt: fullJson['deletedAt'] != null
          ? DateTime.parse(fullJson['deletedAt'])
          : null,
      clinicId: fullJson['clinicId'],
      consults: consults,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'clinicId': clinicId,
      'consults': consults.map((consult) => consult.toJson()).toList(),
    };
  }
}
