import 'package:app_medagenda/core/architecture/usecase/usecase.dart';
import 'package:app_medagenda/core/errors/failure.dart';
import 'package:app_medagenda/features/appointments/domain/entities/appointment.entity.dart';
import 'package:app_medagenda/features/appointments/domain/repositories/appointment.params.dart';
import 'package:app_medagenda/features/appointments/domain/repositories/appointment_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ScheduleAppointmentUsecase
    implements UseCase<AppointmentEntity, ScheduleAppointmentParams> {
  final AppointmentRepository appointmentRepository;

  ScheduleAppointmentUsecase({required this.appointmentRepository});

  @override
  Future<Either<Failure, AppointmentEntity>> call(
      ScheduleAppointmentParams params) async {
    return await appointmentRepository.scheduleAppointment(
        ScheduleAppointmentCmsParams(
            consultId: params.consultId,
            professionalId: params.professionalId,
            dateTime: params.dateTime,
            clientName: params.clientName,
            organizationId: params.organizationId));
  }
}

class ScheduleAppointmentParams extends Equatable {
  final String consultId;
  final String professionalId;
  final String dateTime;
  final String clientName;
  final String organizationId;

  const ScheduleAppointmentParams(
      {required this.consultId,
      required this.professionalId,
      required this.dateTime,
      required this.clientName,
      required this.organizationId});

  @override
  List<Object> get props => [id];
}
