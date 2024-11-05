import 'package:app_medagenda/features/appointments/domain/entities/professional.entity.dart';

class ProfessionalAvailability {
  final ProfessionalEntity professional;
  final List<DateTime> availabilities;

  ProfessionalAvailability({
    required this.professional,
    required this.availabilities,
  });

  factory ProfessionalAvailability.fromJson(Map<String, dynamic> json) {
    List<DateTime> availabilitiesList = [];
    // if (json['availabilities'] != null) {
    //   for (var item in json['availabilities']) {
    //     TZDateTime dateTime =
    //         tz.TZDateTime.from(DateTime.parse(item), tz.local);
    //     availabilitiesList.add(dateTime);
    //   }
    // }

    return ProfessionalAvailability(
      professional: ProfessionalEntity.fromJson(json['professional']),
      availabilities: availabilitiesList,
    );
  }
}
