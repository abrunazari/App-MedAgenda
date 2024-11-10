import 'package:app_medagenda/features/appointments/domain/usecases/get-consult-info.usecase.dart';
import 'package:app_medagenda/features/appointments/ui/controllers/consult-details-controller.dart';
import 'package:get/get.dart';

class ConsultDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ConsultDetailsController(
      getConsultInfoUsecase: Get.find<GetConsultInfoUsecase>(),
    ));
  }
}
