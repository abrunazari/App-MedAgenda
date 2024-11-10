import 'package:app_medagenda/core/errors/failure.dart';
import 'package:app_medagenda/features/appointments/domain/entities/appointment.entity.dart';
import 'package:app_medagenda/features/appointments/domain/entities/clinic.entity.dart';
import 'package:app_medagenda/features/appointments/domain/entities/consult.entity.dart';
import 'package:app_medagenda/features/appointments/domain/repositories/appointment.params.dart';
import 'package:dartz/dartz.dart';

abstract class AppointmentRepository {
  Future<Either<Failure, ClinicEntity>> getClinicInfo(
      GetClinicInfoDataSourceParams params);

  Future<Either<Failure, ConsultAvailability>> getConsultInfo(
      GetConsultInfoDataSourceParams params);

  Future<Either<Failure, AppointmentEntity>> scheduleAppointment(
      ScheduleAppointmentDataSourceParams params);
}
