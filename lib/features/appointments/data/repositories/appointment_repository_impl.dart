import 'package:app_medagenda/core/errors/failure.dart';
import 'package:app_medagenda/features/appointments/data/cms_logic/get-clinic-info.cms_logic.dart';
import 'package:app_medagenda/features/appointments/data/cms_logic/get-consult-info.cms_logic.dart';
import 'package:app_medagenda/features/appointments/data/cms_logic/schedule-appointment.cms_logic.dart';
import 'package:app_medagenda/features/appointments/domain/entities/appointment.entity.dart';
import 'package:app_medagenda/features/appointments/domain/entities/clinic.entity.dart';
import 'package:app_medagenda/features/appointments/domain/entities/consult.entity.dart';
import 'package:app_medagenda/features/appointments/domain/repositories/appointment.params.dart';
import 'package:app_medagenda/features/appointments/domain/repositories/appointment_repository.dart';
import 'package:dartz/dartz.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final GetClinicInfoCmsLogic getClinicInfoCmsLogic;
  final GetConsultInfoCmsLogic getConsultInfoCmsLogic;
  final ScheduleAppointmentCmsLogic scheduleAppointmentCmsLogic;

  AppointmentRepositoryImpl({
    required this.getClinicInfoCmsLogic,
    required this.getConsultInfoCmsLogic,
    required this.scheduleAppointmentCmsLogic,
  });

  @override
  Future<Either<Failure, ClinicEntity>> getClinicInfo(
      GetClinicInfoCmsParams params) async {
    return await getClinicInfoCmsLogic.call(params);
  }

  @override
  Future<Either<Failure, ConsultAvailability>> getConsultInfo(
      GetConsultInfoCmsParams params) async {
    return await getConsultInfoCmsLogic.call(params);
  }

  @override
  Future<Either<Failure, AppointmentEntity>> scheduleAppointment(
      ScheduleAppointmentCmsParams params) async {
    return await scheduleAppointmentCmsLogic.call(params);
  }
}
