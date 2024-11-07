import 'package:app_medagenda/core/architecture/cms_logic/cms_logic.dart';
import 'package:app_medagenda/core/errors/failure.dart';
import 'package:app_medagenda/features/appointments/domain/entities/consult.entity.dart';
import 'package:app_medagenda/features/appointments/domain/repositories/appointment.params.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class GetConsultInfoCmsLogic
    extends CmsLogic<ConsultAvailability, GetConsultInfoCmsParams> {
  final String _baseUrl;

  GetConsultInfoCmsLogic(this._baseUrl);

  @override
  Future<Either<Failure, ConsultAvailability>> call(
      GetConsultInfoCmsParams params) async {
    try {
      final response = await GetConnect().get(
        '$_baseUrl/client/consult-info/${params.consultId}',
        query: {'date': params.date},
      );
      if (response.statusCode == 200) {
        return Right(ConsultAvailability.fromJson(response.body));
      } else {
        return Left(handleError(response));
      }
    } catch (e) {
      return Left(ServerFailure(message: "Erro de conexão com o servidor."));
    }
  }

  Failure handleError(Response response) {
    String errorMessage = "Erro desconhecido";
    switch (response.statusCode) {
      case 400:
        errorMessage = response.body['message'] ?? "Requisição inválida.";
        break;
      case 404:
        errorMessage = "Serviço ou profissional não encontrado.";
        break;
      case 500:
        errorMessage = "Erro interno no servidor.";
        break;
      default:
        errorMessage = "Erro desconhecido.";
    }
    return ServerFailure(message: errorMessage);
  }
}
