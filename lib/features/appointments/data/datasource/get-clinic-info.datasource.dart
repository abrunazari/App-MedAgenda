import 'package:app_medagenda/core/architecture/datasource/datasource.dart';
import 'package:app_medagenda/core/errors/failure.dart';
import 'package:app_medagenda/features/appointments/domain/entities/clinic.entity.dart';
import 'package:app_medagenda/features/appointments/domain/repositories/appointment.params.dart';
import 'package:dartz/dartz.dart';

class GetClinicInfoDataSource
    extends DataSource<ClinicEntity, GetClinicInfoDataSourceParams> {
  GetClinicInfoDataSource();

  @override
  Future<Either<Failure, ClinicEntity>> call(
      GetClinicInfoDataSourceParams params) async {
    final mockResponse = _generateMockResponse(params.clinicId);
    final clinicEntity = ClinicEntity.fromJson(mockResponse);
    return Right(clinicEntity);
  }
}

Map<String, dynamic> _generateMockResponse(String clinicId) {
  return {
    'clinic': {
      'id': clinicId,
      'name': 'Integralis Saúde',
      'imageUrl': null,
      'organizationId': 'org_saude_total',
      'createdAt':
          DateTime.now().subtract(const Duration(days: 365)).toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
      'deletedAt': null,
      'deactivatedAt': null,
    },
    'categories': [
      {
        'id': 'cat1',
        'name': 'Consulta Geral',
        'createdAt': DateTime.now()
            .subtract(const Duration(days: 200))
            .toIso8601String(),
        'updatedAt':
            DateTime.now().subtract(const Duration(days: 50)).toIso8601String(),
        'clinicId': clinicId,
        'consults': [
          {
            'id': 'consult1',
            'name': 'Consulta de Check-up',
            'duration': 30,
            'price': 100.0,
          },
          {
            'id': 'consult2',
            'name': 'Consulta de Acompanhamento',
            'duration': 20,
            'price': 80.0,
          },
        ],
      },
      {
        'id': 'cat2',
        'name': 'Especialidades',
        'createdAt': DateTime.now()
            .subtract(const Duration(days: 180))
            .toIso8601String(),
        'updatedAt':
            DateTime.now().subtract(const Duration(days: 40)).toIso8601String(),
        'clinicId': clinicId,
        'consults': [
          {
            'id': 'consult3',
            'name': 'Consulta de Ginecologia',
            'duration': 45,
            'price': 200.0,
          },
          {
            'id': 'consult4',
            'name': 'Consulta de Dermatologista',
            'duration': 45,
            'price': 300.0,
          },
          {
            'id': 'consult5',
            'name': 'Consulta de Nutricionista',
            'duration': 45,
            'price': 150.0,
          },
          {
            'id': 'consult6',
            'name': 'Consulta de Endocrinologista',
            'duration': 45,
            'price': 350.0,
          },
        ],
      },
    ],
  };
}
