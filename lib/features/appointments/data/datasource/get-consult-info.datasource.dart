import 'package:app_medagenda/core/architecture/datasource/datasource.dart';
import 'package:app_medagenda/core/errors/failure.dart';
import 'package:app_medagenda/features/appointments/domain/entities/consult.entity.dart';
import 'package:app_medagenda/features/appointments/domain/entities/professional-availability.entity.dart';
import 'package:app_medagenda/features/appointments/domain/entities/professional.entity.dart';
import 'package:app_medagenda/features/appointments/domain/repositories/appointment.params.dart';
import 'package:dartz/dartz.dart';

class GetConsultInfoDataSource
    extends DataSource<ConsultAvailability, GetConsultInfoDataSourceParams> {
  GetConsultInfoDataSource();

  final Map<String, dynamic> _mockConsultDataById = _buildMockConsultData();

  @override
  Future<Either<Failure, ConsultAvailability>> call(
      GetConsultInfoDataSourceParams params) async {
    final mockConsultData = _mockConsultDataById[params.consultId];
    if (mockConsultData == null) {
      return Left(ServerFailure(
          message:
              "Consulta não encontrada para o consultId: ${params.consultId}"));
    }

    try {
      final consultEntity = _createConsultEntity(mockConsultData);
      final mockProfessionals =
          _createProfessionalAvailabilities(mockConsultData, params.date);
      final mockAvailableDates = _generateAvailableDates();

      final consultAvailability = ConsultAvailability(
        consults: consultEntity,
        availableProfessionals: mockProfessionals,
        availableDates: mockAvailableDates,
      );

      return Right(consultAvailability);
    } catch (e) {
      return const Left(ServerFailure(message: "Erro ao mockar a resposta."));
    }
  }

  ConsultEntity _createConsultEntity(Map<String, dynamic> mockData) {
    return ConsultEntity(
      id: mockData['consult']['id'],
      name: mockData['consult']['name'],
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
      duration: mockData['consult']['duration'] ?? 0,
      price: mockData['consult']['price'] ?? 0.0,
      categoryId: 'cat1',
    );
  }

  List<ProfessionalAvailabilities> _createProfessionalAvailabilities(
      Map<String, dynamic> mockData, String selectedDate) {
    return (mockData['availableProfessionals'] as List).map((prof) {
      return ProfessionalAvailabilities(
        professional: ProfessionalEntity(
          id: prof['id'],
          name: prof['name'],
          createdAt: DateTime.now().subtract(const Duration(days: 30)),
          isActive: true,
        ),
        availabilities: _generateAvailabilitiesForDate(selectedDate)
            .map(DateTime.parse)
            .toList(),
      );
    }).toList();
  }

  List<DateTime> _generateAvailableDates() {
    return List.generate(
        30, (index) => DateTime.now().add(Duration(days: index)));
  }

  static List<String> _generateAvailabilitiesForDate(String selectedDate) {
    final date = DateTime.parse(selectedDate);
    return List.generate(10, (index) {
      final time = DateTime(date.year, date.month, date.day, 8 + index);
      return time.toIso8601String();
    });
  }

  static Map<String, dynamic> _buildMockConsultData() {
    return {
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
        'availableDates': _generateAvailableDatesForMock(),
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
        'availableDates': _generateAvailableDatesForMock(),
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
        'availableDates': _generateAvailableDatesForMock(),
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
        'availableDates': _generateAvailableDatesForMock(),
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
            'name': 'Dra. Katia Pires',
          },
        ],
        'availableDates': _generateAvailableDatesForMock(),
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
        'availableDates': _generateAvailableDatesForMock(),
      },
    };
  }

  static List<String> _generateAvailableDatesForMock() {
    return List.generate(30,
        (index) => DateTime.now().add(Duration(days: index)).toIso8601String());
  }
}
