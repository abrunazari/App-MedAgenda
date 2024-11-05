import 'package:app_medagenda/core/bindings/clinic-details.binding.dart';
import 'package:app_medagenda/features/appointments/ui/views/clinic/clinic-details.dart';
import 'package:get/get.dart';

abstract class Routes {
  static const CLINIC = '/clinic/:companyId';
  static const CONSULT_DETAILS = '/schedule/:companyId/s/:serviceId';
  static const CONFIRMATION = '/schedule/:companyId/s/:serviceId/confirm';
  static const RESULT = '/schedule/:companyId/s/:serviceId/result/:isSuccess';
}

class Pages {
  static final pages = [
    GetPage(
      name: Routes.CLINIC,
      page: () => const ClinicDetailsContainer(),
      binding: ClinicDetailsBinding(),
    ),
  ];
}
