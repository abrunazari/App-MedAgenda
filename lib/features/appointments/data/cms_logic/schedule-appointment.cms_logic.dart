import 'package:app_medagenda/core/architecture/cms_logic/cms_logic.dart';
import 'package:app_medagenda/core/errors/failure.dart';
import 'package:app_medagenda/features/appointments/domain/entities/appointment.entity.dart';
import 'package:app_medagenda/features/appointments/domain/repositories/appointment.params.dart';
import 'package:dartz/dartz.dart';

class ScheduleAppointmentCmsLogic
    extends CmsLogic<AppointmentEntity, ScheduleAppointmentCmsParams> {
  ScheduleAppointmentCmsLogic();

  @override
  Future<Either<Failure, AppointmentEntity>> call(
      ScheduleAppointmentCmsParams params) async {
    final mockResponse = {
      'consultId': params.consultId,
      'professionalId': params.professionalId,
      'dateTime': params.dateTime,
      'clientInfo': {'name': params.clientName},
      'organizationId': params.organizationId,
    };

    return Right(AppointmentEntity.fromJson(mockResponse));
  }
}
