import 'package:app_medagenda/core/routes/app-routes.dart';
import 'package:app_medagenda/features/appointments/domain/entities/appointment.entity.dart';
import 'package:app_medagenda/features/appointments/domain/usecases/schedule-appointment.usecase.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class AppointmentConfirmationController extends GetxController {
  final ScheduleAppointmentUsecase scheduleAppointmentUsecase;

  AppointmentConfirmationController({
    required this.scheduleAppointmentUsecase,
  });

  Rxn<AppointmentEntity> appointment = Rxn<AppointmentEntity>();
  RxString errorMessage = ''.obs;
  RxBool isLoading = false.obs;

  late TextEditingController nameController;
  RxBool isNameValid = false.obs;

  final consultId = RxString('');
  final professionalId = RxString('');
  final dateTime = Rxn<DateTime>();
  final RxString organizationId = ''.obs;
  final GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    initializeNameController();
    loadStoredData();
  }

  void initializeNameController() {
    nameController = TextEditingController();
    nameController.addListener(() {
      final nameLength = nameController.text.trim().length;
      isNameValid.value = nameLength >= 3 && nameLength <= 50;
    });
  }

  void loadStoredData() {
    consultId.value = box.read('consultId') ?? '';
    professionalId.value = box.read('professionalId') ?? '';
    organizationId.value = box.read('organizationId') ?? '';

    if (box.hasData('clientName')) {
      nameController.text = box.read('clientName');
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }

  void scheduleAppointment({
    required String consultId,
    required String professionalId,
    required DateTime dateTime,
    required String clientName,
    required String organizationId,
  }) async {
    if (nameController.text.trim().isEmpty) {
      errorMessage('Por favor, insira seu nome para continuar.');
      return;
    }

    isLoading(true);

    box.write('clientName', nameController.text);

    final result =
        await scheduleAppointmentUsecase.call(ScheduleAppointmentParams(
      consultId: consultId,
      professionalId: professionalId,
      dateTime: dateTime.toIso8601String(),
      clientName: nameController.text,
      organizationId: organizationId,
    ));

    result.fold(
      (_) => {},
      (appointmentData) {
        appointment(appointmentData);
        Get.toNamed(Routes.RESULT, parameters: {
          'clinicId': organizationId,
          'consultId': consultId,
          'isSuccess': 'true',
        });
      },
    );

    isLoading(false);
  }
}
