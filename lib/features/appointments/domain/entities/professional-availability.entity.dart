import 'package:app_medagenda/features/appointments/domain/entities/professional.entity.dart';

class ProfessionalAvailabilities {
  final ProfessionalEntity professional;
  final List<DateTime> availabilities;

  ProfessionalAvailabilities({
    required this.professional,
    required this.availabilities,
  });

  factory ProfessionalAvailabilities.fromJson(Map<String, dynamic> json) {
    List<DateTime> availabilitiesList = [];

    if (json['availabilities'] != null) {
      for (var item in json['availabilities']) {
        DateTime dateTime = DateTime.parse(item);
        availabilitiesList.add(dateTime);
      }
    }

    return ProfessionalAvailabilities(
      professional: ProfessionalEntity.fromJson(json['professional']),
      availabilities: availabilitiesList,
    );
  }
}
