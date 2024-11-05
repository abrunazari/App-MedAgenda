import 'package:app_medagenda/features/appointments/ui/views/clinic/clinic-details.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() async {
    //! Services
    // Get.lazyPut(() => AppointmentService(), fenix: true);

    //! Controllers
    Get.lazyPut(() => const ClinicDetailsContainer(), fenix: true);
  }
}
