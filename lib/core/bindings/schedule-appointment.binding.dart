import 'package:app_medagenda/features/appointments/domain/usecases/schedule-appointment.usecase.dart';
import 'package:app_medagenda/features/appointments/ui/controllers/schedule-appointment-controller.dart';
import 'package:get/get.dart';

class ScheduleAppointmentBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AppointmentConfirmationController(
      scheduleAppointmentUsecase: Get.find<ScheduleAppointmentUsecase>(),
    ));
  }
}
