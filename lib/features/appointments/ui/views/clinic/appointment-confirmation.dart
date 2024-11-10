import 'package:app_medagenda/core/constants/color.dart';
import 'package:app_medagenda/core/utils/format-duration.dart';
import 'package:app_medagenda/core/utils/format-price.dart';
import 'package:app_medagenda/core/widgets/layout.dart';
import 'package:app_medagenda/core/widgets/primary-button.dart';
import 'package:app_medagenda/features/appointments/ui/controllers/schedule-appointment-controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class AppointmentConfirmationContainer
    extends GetView<AppointmentConfirmationController> {
  final box = GetStorage();

  late final String consultName;
  late final int consultDuration;
  late final double consultPrice;
  late final String professionalName;
  late final String selectedTime;
  late final String selectedDate;
  late final String organizationId;
  late final String consultId;
  late final String professionalId;

  AppointmentConfirmationContainer({Key? key}) : super(key: key) {
    final Map<String, dynamic>? args = Get.arguments;

    consultName = args?['consultName'] ?? 'Nome de Serviço Padrão';
    consultDuration = args?['consultDuration'] ?? 0;
    consultPrice = (args?['consultPrice'] ?? 0).toDouble();
    professionalName = args?['professionalName'] ?? 'Profissional Desconhecido';
    selectedTime = args?['selectedTime'] ?? '00:00';
    selectedDate = args?['selectedDate'] ?? DateTime.now().toIso8601String();
    organizationId = args?['organizationId'] ?? '';
    consultId = args?['consultId'] ?? '';
    professionalId = args?['professionalId'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildAppointmentConfirmation(context),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                child: _buildScheduleButton(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentConfirmation(BuildContext context) {
    DateTime parsedDate = DateTime.parse(selectedDate);
    String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);

    TextEditingController nameController = controller.nameController;

    String formattedDuration = formatDuration(consultDuration);
    String formattedPrice = formatPrice(consultPrice);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Confirmar Agendamento',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(consultName,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainDark)),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        style: const TextStyle(
                            fontSize: 18, color: Colors.black87),
                        children: <TextSpan>[
                          const TextSpan(
                              text: 'Duração: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: formattedDuration),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        style: const TextStyle(
                            fontSize: 18, color: Colors.black87),
                        children: <TextSpan>[
                          const TextSpan(
                              text: 'Preço: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: formattedPrice),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        style: const TextStyle(
                            fontSize: 18, color: Colors.black87),
                        children: <TextSpan>[
                          const TextSpan(
                              text: 'Profissional: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: professionalName),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        style: const TextStyle(
                            fontSize: 18, color: Colors.black87),
                        children: <TextSpan>[
                          const TextSpan(
                              text: 'Data: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: formattedDate),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        style: const TextStyle(
                            fontSize: 18, color: Colors.black87),
                        children: <TextSpan>[
                          const TextSpan(
                              text: 'Horário: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: selectedTime),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Por favor, preencha seu nome',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Seu Nome',
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.main, width: 2.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildScheduleButton(BuildContext context) {
    TextEditingController nameController = controller.nameController;

    return Obx(() {
      return PrimaryButton(
        text: 'Agendar Horário',
        width: double.infinity,
        height: 60,
        onPressed: controller.isNameValid.value
            ? () async {
                String datePart = selectedDate.split('T')[0];
                String dateTimeString = '$datePart $selectedTime:00';
                DateTime dateTime;

                dateTime = DateTime.parse(dateTimeString);

                controller.scheduleAppointment(
                  consultId: consultId,
                  professionalId: professionalId,
                  dateTime: dateTime,
                  organizationId: organizationId,
                  clientName: nameController.text,
                );
              }
            : null,
      );
    });
  }
}
