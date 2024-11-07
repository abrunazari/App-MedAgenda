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
    const String baseUrl =
        'https://api_base_url'; // Defina a URL base da API aqui.

    //! CMS LOGIC
    Get.lazyPut(() => GetClinicInfoCmsLogic(baseUrl), fenix: true);
    Get.lazyPut(() => GetConsultInfoCmsLogic(baseUrl), fenix: true);
    Get.lazyPut(() => ScheduleAppointmentCmsLogic(baseUrl), fenix: true);

    //! REPOSITORIES
    Get.lazyPut(
        () => AppointmentRepositoryImpl(
            getClinicInfoCmsLogic: Get.find<GetClinicInfoCmsLogic>(),
            getConsultInfoCmsLogic: Get.find<GetConsultInfoCmsLogic>(),
            scheduleAppointmentCmsLogic:
                Get.find<ScheduleAppointmentCmsLogic>()),
        fenix: true);

    //! USECASES
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
