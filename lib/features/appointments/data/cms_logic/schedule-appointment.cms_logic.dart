import 'package:app_medagenda/core/architecture/cms_logic/cms_logic.dart';
import 'package:app_medagenda/core/errors/failure.dart';
import 'package:app_medagenda/features/appointments/domain/entities/appointment.entity.dart';
import 'package:app_medagenda/features/appointments/domain/repositories/appointment.params.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class ScheduleAppointmentCmsLogic
    extends CmsLogic<AppointmentEntity, ScheduleAppointmentCmsParams> {
  final String _baseUrl;

  ScheduleAppointmentCmsLogic(this._baseUrl);

  @override
  Future<Either<Failure, AppointmentEntity>> call(
      ScheduleAppointmentCmsParams params) async {
    final body = {
      'consultId': params.consultId,
      'professionalId': params.professionalId,
      'dateTime': params.dateTime,
      'clientInfo': {'name': params.clientName},
      'organizationId': params.organizationId,
    };

    try {
      final response =
          await GetConnect().post('$_baseUrl/client/schedule', body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(AppointmentEntity.fromJson(response.body));
      } else {
        String errorMessage =
            "Erro desconhecido. Código de erro: ${response.statusCode}";
        switch (response.statusCode) {
          case 400:
            errorMessage = "Dados inválidos ou horário não disponível.";
            break;
          case 404:
            errorMessage = "Serviço ou profissional não encontrado.";
            break;
          case 500:
            errorMessage = "Erro interno no servidor.";
            break;
        }
        return Left(ServerFailure(message: errorMessage));
      }
    } catch (e) {
      return Left(ServerFailure(
          message:
              "Erro de conexão com o servidor. Por favor, verifique sua internet e tente novamente."));
    }
  }
}
