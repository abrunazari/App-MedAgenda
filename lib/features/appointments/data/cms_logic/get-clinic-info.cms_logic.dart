import 'package:app_medagenda/core/architecture/cms_logic/cms_logic.dart';
import 'package:app_medagenda/core/errors/failure.dart';
import 'package:app_medagenda/features/appointments/domain/entities/clinic.entity.dart';
import 'package:app_medagenda/features/appointments/domain/repositories/appointment.params.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class GetClinicInfoCmsLogic
    extends CmsLogic<ClinicEntity, GetClinicInfoCmsParams> {
  final String _baseUrl;

  GetClinicInfoCmsLogic(this._baseUrl);

  @override
  Future<Either<Failure, ClinicEntity>> call(
      GetClinicInfoCmsParams params) async {
    try {
      final response = await GetConnect()
          .get('$_baseUrl/client/clinic-info/${params.clinicId}');
      if (response.statusCode == 200) {
        return Right(ClinicEntity.fromJson(response.body));
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
      case 403:
        errorMessage = "Esta clínica está desativada.";
        break;
      case 404:
        errorMessage = "Clínica não encontrada.";
        break;
      default:
        errorMessage = "Erro desconhecido.";
    }
    return ServerFailure(message: errorMessage);
  }
}
