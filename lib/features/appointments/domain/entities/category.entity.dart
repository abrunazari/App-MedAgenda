import 'package:app_medagenda/features/appointments/domain/entities/consult.entity.dart';

class CategoryEntity {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String barberShopId;
  final List<ConsultEntity> consults;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.barberShopId,
    this.consults = const [],
  });

  @override
  String toString() {
    return 'CategoryEntity(id: $id, name: $name, consults: ${consults.length})';
  }

  factory CategoryEntity.fromJson(Map<String, dynamic> fullJson) {
    var consultsJson = fullJson['consults'] as List<dynamic>? ?? [];

    List<ConsultEntity> consults = consultsJson.map((serviceJson) {
      return ConsultEntity.fromJson(serviceJson);
    }).toList();

    return CategoryEntity(
      id: fullJson['id'],
      name: fullJson['name'],
      createdAt: DateTime.parse(fullJson['createdAt']),
      updatedAt: DateTime.parse(fullJson['updatedAt']),
      deletedAt: fullJson['deletedAt'] != null
          ? DateTime.parse(fullJson['deletedAt'])
          : null,
      barberShopId: fullJson['barberShopId'],
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
      'barberShopId': barberShopId,
      'consults': consults.map((consult) => consult.toJson()).toList(),
    };
  }
}
