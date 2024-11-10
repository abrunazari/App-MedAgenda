import 'package:app_medagenda/core/architecture/cms_logic/cms_logic.dart';
import 'package:app_medagenda/core/errors/failure.dart';
import 'package:app_medagenda/features/appointments/domain/entities/consult.entity.dart';
import 'package:app_medagenda/features/appointments/domain/entities/professional-availability.entity.dart';
import 'package:app_medagenda/features/appointments/domain/entities/professional.entity.dart';
import 'package:app_medagenda/features/appointments/domain/repositories/appointment.params.dart';
import 'package:dartz/dartz.dart';

class GetConsultInfoCmsLogic
    extends CmsLogic<ConsultAvailability, GetConsultInfoCmsParams> {
  GetConsultInfoCmsLogic();

  final Map<String, dynamic> mockConsultDataById = {
    'consult1': {
      'consult': {
        'id': 'consult1',
        'name': 'Consulta de Check-up',
        'duration': 30,
        'price': 100.0,
      },
      'availableProfessionals': [
        {
          'id': 'prof1',
          'name': 'Dr. João Silva',
        },
        {
          'id': 'prof2',
          'name': 'Dra. Maria Oliveira',
        },
        {
          'id': 'prof3',
          'name': 'Dr. Pedro Almeida',
        },
      ],
      'availableDates': List.generate(
        30,
        (index) => DateTime.now().add(Duration(days: index)).toIso8601String(),
      ),
    },
    'consult2': {
      'consult': {
        'id': 'consult2',
        'name': 'Consulta de Acompanhamento',
        'duration': 20,
        'price': 80.0,
      },
      'availableProfessionals': [
        {
          'id': 'prof2',
          'name': 'Dra. Maria Oliveira',
        },
        {
          'id': 'prof3',
          'name': 'Dr. Pedro Almeida',
        },
      ],
      'availableDates': List.generate(
        30,
        (index) => DateTime.now().add(Duration(days: index)).toIso8601String(),
      ),
    },
    'consult3': {
      'consult': {
        'id': 'consult3',
        'name': 'Consulta de Ginecologia',
        'duration': 45,
        'price': 200.0,
      },
      'availableProfessionals': [
        {
          'id': 'prof3',
          'name': 'Dr. Pedro Almeida',
        },
        {
          'id': 'prof4',
          'name': 'Dra. Ana Souza',
        },
      ],
      'availableDates': List.generate(
        30,
        (index) => DateTime.now().add(Duration(days: index)).toIso8601String(),
      ),
    },
    'consult4': {
      'consult': {
        'id': 'consult4',
        'name': 'Consulta de Dermatologista',
        'duration': 45,
        'price': 300.0,
      },
      'availableProfessionals': [
        {
          'id': 'prof4',
          'name': 'Dra. Ana Souza',
        },
      ],
      'availableDates': List.generate(
        30,
        (index) => DateTime.now().add(Duration(days: index)).toIso8601String(),
      ),
    },
    'consult5': {
      'consult': {
        'id': 'consult5',
        'name': 'Consulta de Nutricionista',
        'duration': 45,
        'price': 150.0,
      },
      'availableProfessionals': [
        {
          'id': 'prof5',
          'name': 'Dra. Carla Santos',
        },
        {
          'id': 'prof6',
          'name': 'Dr. João Silva',
        },
      ],
      'availableDates': List.generate(
        30,
        (index) => DateTime.now().add(Duration(days: index)).toIso8601String(),
      ),
    },
    'consult6': {
      'consult': {
        'id': 'consult6',
        'name': 'Consulta de Endocrinologista',
        'duration': 45,
        'price': 150.0,
      },
      'availableProfessionals': [
        {
          'id': 'prof6',
          'name': 'Dra. Carla Santos',
        },
      ],
      'availableDates': List.generate(
        30,
        (index) => DateTime.now().add(Duration(days: index)).toIso8601String(),
      ),
    },
  };

  @override
  Future<Either<Failure, ConsultAvailability>> call(
      GetConsultInfoCmsParams params) async {
    final mockConsultData = mockConsultDataById[params.consultId];
    if (mockConsultData == null) {
      return Left(ServerFailure(
          message:
              "Consulta não encontrada para o consultId: ${params.consultId}"));
    }

    try {
      final consultEntity = ConsultEntity(
        id: mockConsultData['consult']['id'],
        name: mockConsultData['consult']['name'],
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now(),
        duration: mockConsultData['consult']['duration'] ?? 0,
        price: mockConsultData['consult']['price'] ?? 0.0,
        categoryId: 'cat1',
      );

      List<ProfessionalAvailability> mockProfessionals =
          (mockConsultData['availableProfessionals'] as List)
              .map((prof) => ProfessionalAvailability(
                    professional: ProfessionalEntity(
                      id: prof['id'],
                      name: prof['name'],
                      createdAt:
                          DateTime.now().subtract(const Duration(days: 30)),
                      isActive: true,
                    ),
                    availabilities: generateAvailabilitiesForDate(params.date)
                        .map((e) => DateTime.parse(e))
                        .toList(),
                  ))
              .toList();

      List<DateTime> mockAvailableDates = List.generate(
        30,
        (index) => DateTime.now().add(Duration(days: index)),
      );

      final consultAvailability = ConsultAvailability(
        consults: consultEntity,
        availableProfessionals: mockProfessionals,
        availableDates: mockAvailableDates,
      );

      return Right(consultAvailability);
    } catch (e) {
      return Left(ServerFailure(message: "Erro ao mockar a resposta: $e"));
    }
  }

  static List<String> generateAvailabilitiesForDate(String selectedDate) {
    final date = DateTime.parse(selectedDate);
    final availabilities = <String>[];

    for (int hour = 8; hour <= 17; hour++) {
      final time = DateTime(date.year, date.month, date.day, hour);
      availabilities.add(time.toIso8601String());
    }
    return availabilities;
  }
}
