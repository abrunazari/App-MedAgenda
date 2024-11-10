import 'package:app_medagenda/core/bindings/clinic-details.binding.dart';
import 'package:app_medagenda/core/bindings/consult-details.binding.dart';
import 'package:app_medagenda/core/bindings/schedule-appointment.binding.dart';
import 'package:app_medagenda/core/routes/app-routes.dart';
import 'package:app_medagenda/features/appointments/ui/views/clinic/appointment-confirmation.dart';
import 'package:app_medagenda/features/appointments/ui/views/clinic/appointment-result.dart';
import 'package:app_medagenda/features/appointments/ui/views/clinic/clinic-details.dart';
import 'package:app_medagenda/features/appointments/ui/views/clinic/consult-details.dart';
import 'package:get/get.dart';

final pages = [
  GetPage(
    name: Routes.CLINIC,
    page: () => const ClinicDetailsContainer(),
    binding: ClinicDetailsBinding(),
  ),
  GetPage(
    name: Routes.CONSULT_DETAILS,
    page: () => const ConsultDetailsContainer(),
    binding: ConsultDetailsBinding(),
  ),
  GetPage(
    name: Routes.CONFIRMATION,
    page: () => AppointmentConfirmationContainer(),
    binding: ScheduleAppointmentBinding(),
  ),
  GetPage(
    name: Routes.RESULT,
    page: () => AppointmentResultContainer(
      isSuccess: Get.parameters['isSuccess'] == 'true',
    ),
  ),
];
