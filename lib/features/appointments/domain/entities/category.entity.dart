import 'package:app_medagenda/features/appointments/domain/entities/consult.entity.dart';

class CategoryEntity {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String clinicId;
  final List<ConsultEntity> consults;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.clinicId,
    this.consults = const [],
  });

  @override
  String toString() {
    return 'CategoryEntity(id: $id, name: $name, consults: ${consults.length})';
  }

  factory CategoryEntity.fromJson(Map<String, dynamic> categoryJson) {
    try {
      List<ConsultEntity> consults =
          (categoryJson['consults'] as List<dynamic>? ?? []).map((consultJson) {
        return ConsultEntity.fromJson(consultJson);
      }).toList();

      return CategoryEntity(
        id: categoryJson['id'] ?? 'default_id',
        name: categoryJson['name'] ?? 'Unnamed Category',
        createdAt: categoryJson['createdAt'] != null
            ? DateTime.parse(categoryJson['createdAt'])
            : DateTime.now(),
        updatedAt: categoryJson['updatedAt'] != null
            ? DateTime.parse(categoryJson['updatedAt'])
            : DateTime.now(),
        deletedAt: categoryJson['deletedAt'] != null
            ? DateTime.parse(categoryJson['deletedAt'])
            : null,
        clinicId: categoryJson['clinicId'] ?? 'default_clinic_id',
        consults: consults,
      );
    } catch (e) {
      print("Erro ao criar CategoryEntity: $e");
      rethrow;
    }
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'clinicId': clinicId,
      'consults': consults.map((consult) => consult.toJson()).toList(),
    };
  }
}
