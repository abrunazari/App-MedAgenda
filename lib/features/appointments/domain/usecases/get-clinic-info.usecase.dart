import 'package:app_medagenda/core/architecture/usecase/usecase.dart';
import 'package:app_medagenda/core/errors/failure.dart';
import 'package:app_medagenda/features/appointments/domain/entities/clinic.entity.dart';
import 'package:app_medagenda/features/appointments/domain/repositories/appointment.params.dart';
import 'package:app_medagenda/features/appointments/domain/repositories/appointment_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetClinicInfoUsecase
    implements UseCase<ClinicEntity, GetClinicInfoParams> {
  final AppointmentRepository appointmentRepository;

  GetClinicInfoUsecase({required this.appointmentRepository});

  @override
  Future<Either<Failure, ClinicEntity>> call(GetClinicInfoParams params) async {
    return await appointmentRepository
        .getClinicInfo(GetClinicInfoCmsParams(clinicId: params.clinicId));
  }
}

class GetClinicInfoParams extends Equatable {
  final String clinicId;

  const GetClinicInfoParams({required this.clinicId});

  @override
  List<Object> get props => [id];
}
