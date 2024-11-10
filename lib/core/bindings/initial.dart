import 'package:app_medagenda/features/appointments/data/cms_logic/get-clinic-info.cms_logic.dart';
import 'package:app_medagenda/features/appointments/data/cms_logic/get-consult-info.cms_logic.dart';
import 'package:app_medagenda/features/appointments/data/cms_logic/schedule-appointment.cms_logic.dart';
import 'package:app_medagenda/features/appointments/data/repositories/appointment_repository_impl.dart';
import 'package:app_medagenda/features/appointments/domain/usecases/get-clinic-info.usecase.dart';
import 'package:app_medagenda/features/appointments/domain/usecases/get-consult-info.usecase.dart';
import 'package:app_medagenda/features/appointments/domain/usecases/schedule-appointment.usecase.dart';

import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetClinicInfoCmsLogic(), fenix: true);
    Get.lazyPut(() => GetConsultInfoCmsLogic(), fenix: true);
    Get.lazyPut(() => ScheduleAppointmentCmsLogic(), fenix: true);

    Get.lazyPut(
        () => AppointmentRepositoryImpl(
            getClinicInfoCmsLogic: Get.find<GetClinicInfoCmsLogic>(),
            getConsultInfoCmsLogic: Get.find<GetConsultInfoCmsLogic>(),
            scheduleAppointmentCmsLogic:
                Get.find<ScheduleAppointmentCmsLogic>()),
        fenix: true);

    Get.lazyPut(
        () => GetClinicInfoUsecase(
            appointmentRepository: Get.find<AppointmentRepositoryImpl>()),
        fenix: true);
    Get.lazyPut(
        () => GetConsultInfoUsecase(
            appointmentRepository: Get.find<AppointmentRepositoryImpl>()),
        fenix: true);
    Get.lazyPut(
        () => ScheduleAppointmentUsecase(
            appointmentRepository: Get.find<AppointmentRepositoryImpl>()),
        fenix: true);
  }
}
