import 'package:app_medagenda/features/appointments/domain/usecases/get-clinic-info.usecase.dart';
import 'package:app_medagenda/features/appointments/ui/controllers/clinic-details-controller.dart';
import 'package:get/instance_manager.dart';

class ClinicDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ClinicDetailsController(
      getClinicInfoUsecase: Get.find<GetClinicInfoUsecase>(),
    ));
  }
}
