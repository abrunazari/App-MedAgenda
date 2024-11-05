import 'package:app_medagenda/features/appointments/domain/entities/professional-availability.entity.dart';

class ConsultAvailability {
  final ConsultEntity services;
  final List<ProfessionalAvailability> availableProfessionals;
  final List<DateTime> availableDates;

  ConsultAvailability({
    required this.services,
    required this.availableProfessionals,
    required this.availableDates,
  });

  factory ConsultAvailability.fromJson(Map<String, dynamic> json) {
    ConsultEntity services = ConsultEntity.fromJson(json['service']);

    List<ProfessionalAvailability> availableProfessionals = [];
    if (json.containsKey('availableProfessionals')) {
      availableProfessionals = (json['availableProfessionals'] as List)
          .map((prof) => ProfessionalAvailability.fromJson(prof))
          .toList();
    }

    List<DateTime> availableDates = [];
    if (json.containsKey('availableDates')) {
      availableDates = (json['availableDates'] as List)
          .map((date) => DateTime.parse(date))
          .toList();
    }

    return ConsultAvailability(
      services: services,
      availableProfessionals: availableProfessionals,
      availableDates: availableDates,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'services': services.toJson(),
      'availableProfessionals': availableProfessionals,
      'availableDates':
          availableDates.map((date) => date.toIso8601String()).toList(),
    };
  }
}

class ConsultEntity {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int durationInMinutes;
  final double value;
  final String categoryId;

  ConsultEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.durationInMinutes,
    required this.value,
    required this.categoryId,
  });

  @override
  String toString() {
    return 'ServiceEntity(id: $id, name: $name, duration: $durationInMinutes, value: $value)';
  }

  factory ConsultEntity.fromJson(Map<String, dynamic> json) {
    return ConsultEntity(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      durationInMinutes: json['durationInMinutes'],
      value: json['value'],
      categoryId: json['categoryId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'durationInMinutes': durationInMinutes,
      'value': value,
      'categoryId': categoryId,
    };
  }
}
