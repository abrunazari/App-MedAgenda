import 'package:app_medagenda/core/errors/failure.dart';
import 'package:app_medagenda/features/appointments/data/datasource/get-clinic-info.datasource.dart';
import 'package:app_medagenda/features/appointments/data/datasource/get-consult-info.datasource.dart';
import 'package:app_medagenda/features/appointments/data/datasource/schedule-appointment.datasource.dart';

import 'package:app_medagenda/features/appointments/domain/entities/appointment.entity.dart';
import 'package:app_medagenda/features/appointments/domain/entities/clinic.entity.dart';
import 'package:app_medagenda/features/appointments/domain/entities/consult.entity.dart';
import 'package:app_medagenda/features/appointments/domain/repositories/appointment.params.dart';
import 'package:app_medagenda/features/appointments/domain/repositories/appointment_repository.dart';
import 'package:dartz/dartz.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final GetClinicInfoDataSource getClinicInfoDataSource;
  final GetConsultInfoDataSource getConsultInfoDataSource;
  final ScheduleAppointmentDataSource scheduleAppointmentDataSource;

  AppointmentRepositoryImpl({
    required this.getClinicInfoDataSource,
    required this.getConsultInfoDataSource,
    required this.scheduleAppointmentDataSource,
  });

  @override
  Future<Either<Failure, ClinicEntity>> getClinicInfo(
      GetClinicInfoDataSourceParams params) async {
    return await getClinicInfoDataSource.call(params);
  }

  @override
  Future<Either<Failure, ConsultAvailability>> getConsultInfo(
      GetConsultInfoDataSourceParams params) async {
    return await getConsultInfoDataSource.call(params);
  }

  @override
  Future<Either<Failure, AppointmentEntity>> scheduleAppointment(
      ScheduleAppointmentDataSourceParams params) async {
    return await scheduleAppointmentDataSource.call(params);
  }
}
