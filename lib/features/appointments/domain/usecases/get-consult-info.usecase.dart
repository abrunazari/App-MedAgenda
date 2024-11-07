import 'package:app_medagenda/core/architecture/usecase/usecase.dart';
import 'package:app_medagenda/core/errors/failure.dart';
import 'package:app_medagenda/features/appointments/domain/entities/consult.entity.dart';
import 'package:app_medagenda/features/appointments/domain/repositories/appointment.params.dart';
import 'package:app_medagenda/features/appointments/domain/repositories/appointment_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetConsultInfoUsecase
    implements UseCase<ConsultAvailability, GetConsultInfoParams> {
  final AppointmentRepository appointmentRepository;

  GetConsultInfoUsecase({required this.appointmentRepository});

  Future<Either<Failure, ConsultAvailability>> call(
      GetConsultInfoParams params) async {
    return await appointmentRepository.getConsultInfo(GetConsultInfoCmsParams(
        consultId: params.consultId, date: params.date));
  }
}

class GetConsultInfoParams extends Equatable {
  final String consultId;
  final String date;

  const GetConsultInfoParams({required this.consultId, required this.date});

  @override
  List<Object> get props => [id];
}

class InvalidInputFailure extends Failure {
  @override
  final String message;

  InvalidInputFailure({this.message = "Invalid input."});

  @override
  List<Object> get props => [message];
}
