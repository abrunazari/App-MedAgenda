import 'package:app_medagenda/features/appointments/data/datasource/get-clinic-info.datasource.dart';
import 'package:app_medagenda/features/appointments/data/datasource/get-consult-info.datasource.dart';
import 'package:app_medagenda/features/appointments/data/datasource/schedule-appointment.datasource.dart';
import 'package:app_medagenda/features/appointments/data/repositories/appointment_repository_impl.dart';
import 'package:app_medagenda/features/appointments/domain/repositories/appointment_repository.dart';
import 'package:app_medagenda/features/appointments/domain/usecases/get-clinic-info.usecase.dart';
import 'package:app_medagenda/features/appointments/domain/usecases/get-consult-info.usecase.dart';
import 'package:app_medagenda/features/appointments/domain/usecases/schedule-appointment.usecase.dart';

import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetClinicInfoDataSource(), fenix: true);
    Get.lazyPut(() => GetConsultInfoDataSource(), fenix: true);
    Get.lazyPut(() => ScheduleAppointmentDataSource(), fenix: true);

    Get.lazyPut<AppointmentRepository>(
        () => AppointmentRepositoryImpl(
            getClinicInfoDataSource: Get.find<GetClinicInfoDataSource>(),
            getConsultInfoDataSource: Get.find<GetConsultInfoDataSource>(),
            scheduleAppointmentDataSource:
                Get.find<ScheduleAppointmentDataSource>()),
        fenix: true);

    Get.lazyPut(
        () => GetClinicInfoUsecase(
            appointmentRepository: Get.find<AppointmentRepository>()),
        fenix: true);
    Get.lazyPut(
        () => GetConsultInfoUsecase(
            appointmentRepository: Get.find<AppointmentRepository>()),
        fenix: true);
    Get.lazyPut(
        () => ScheduleAppointmentUsecase(
            appointmentRepository: Get.find<AppointmentRepository>()),
        fenix: true);
  }
}
