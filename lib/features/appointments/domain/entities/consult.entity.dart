import 'package:app_medagenda/features/appointments/domain/entities/professional-availability.entity.dart';

class ConsultAvailability {
  final ConsultEntity consults;
  final List<ProfessionalAvailabilities> availableProfessionals;
  final List<DateTime> availableDates;

  ConsultAvailability({
    required this.consults,
    required this.availableProfessionals,
    required this.availableDates,
  });

  factory ConsultAvailability.fromJson(Map<String, dynamic> json) {
    ConsultEntity consults = ConsultEntity.fromJson(json['consult']);

    List<ProfessionalAvailabilities> availableProfessionals = [];
    if (json.containsKey('availableProfessionals')) {
      availableProfessionals = (json['availableProfessionals'] as List)
          .map((prof) => ProfessionalAvailabilities.fromJson(prof))
          .toList();
    }

    List<DateTime> availableDates = [];
    if (json.containsKey('availableDates')) {
      availableDates = (json['availableDates'] as List)
          .map((date) => DateTime.parse(date))
          .toList();
    }

    return ConsultAvailability(
      consults: consults,
      availableProfessionals: availableProfessionals,
      availableDates: availableDates,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'consults': consults.toJson(),
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
  final int duration;
  final double price;
  final String categoryId;

  ConsultEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.duration,
    required this.price,
    required this.categoryId,
  });

  @override
  String toString() {
    return 'ConsultEntity(id: $id, name: $name, duration: $duration, value: $price)';
  }

  factory ConsultEntity.fromJson(Map<String, dynamic> json) {
    return ConsultEntity(
      id: json['id'] ?? 'default-id',
      name: json['name'] ?? 'Unnamed Consult',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      deletedAt:
          json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
      duration: json['duration'] ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      categoryId: json['categoryId'] ?? 'default-category-id',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'duration': duration,
      'price': price,
      'categoryId': categoryId,
    };
  }
}
