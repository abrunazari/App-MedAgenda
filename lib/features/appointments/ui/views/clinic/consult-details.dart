import 'package:app_medagenda/core/constants/color.dart';
import 'package:app_medagenda/core/routes/app-routes.dart';
import 'package:app_medagenda/core/widgets/date-carousel.dart';
import 'package:app_medagenda/core/widgets/layout.dart';
import 'package:app_medagenda/features/appointments/domain/entities/professional-availability.entity.dart';
import 'package:app_medagenda/features/appointments/domain/entities/professional.entity.dart';
import 'package:app_medagenda/features/appointments/ui/controllers/consult-details-controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ConsultDetailsContainer extends GetView<ConsultDetailsController> {
  const ConsultDetailsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Detalhes da Consulta",
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildDateSuggestions(),
            const Divider(),
            buildProfessionalsList(context),
          ],
        ),
      ),
    );
  }

  Widget buildDateSuggestions() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Obx(() {
            return Column(
              children: [
                DateCarousel(
                  dates: controller.availableDates
                      .map((dateString) =>
                          DateFormat('yyyy-MM-dd').parse(dateString))
                      .toList()
                    ..sort((a, b) => a.compareTo(b)),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget buildProfessionalsList(BuildContext context) {
    return Obx(() {
      if (controller.professionals.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Não há especialista disponíveis para a data selecionada.',
              style: TextStyle(color: AppColors.main, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        return Column(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Escolha um especialista',
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ...controller.professionals.map((professional) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: buildProfessionalTile(context, professional),
              );
            }).toList(),
          ],
        );
      }
    });
  }

  Widget buildProfessionalTile(
      BuildContext context, ProfessionalAvailability professionalAvailability) {
    ProfessionalEntity professional = professionalAvailability.professional;
    ImageProvider backgroundImage;
    if (professional.imageUrl != null && professional.imageUrl!.isNotEmpty) {
      backgroundImage = NetworkImage(professional.imageUrl!);
    } else {
      backgroundImage = const AssetImage("images/avatar.png");
    }

    return ExpansionTile(
      leading: CircleAvatar(
        backgroundImage: backgroundImage,
        radius: 24,
      ),
      title: Text(
        professional.name,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppColors.mainDark,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
      ),
      iconColor: AppColors.mainDark,
      children: [
        professionalAvailability.availabilities.isEmpty
            ? buildNoAvailableTimes()
            : buildAvailableTimesGrid(context, professionalAvailability),
      ],
    );
  }

  Widget buildNoAvailableTimes() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: const Center(
        child: Text(
          'Sem horários disponíveis. Escolha outro dia!',
          style: TextStyle(
              color: AppColors.main, fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget buildAvailableTimesGrid(
      BuildContext context, ProfessionalAvailability professionalAvailability) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 600 ? 8 : 4;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 2.5,
        ),
        itemCount: professionalAvailability.availabilities.length,
        itemBuilder: (BuildContext context, int index) {
          final time = professionalAvailability.availabilities[index];
          final formattedTime = DateFormat('HH:mm').format(time);

          return OutlinedButton(
            onPressed: () {
              var route = Routes.CONFIRMATION
                  .replaceFirst(':clinicId', controller.organizationId.value)
                  .replaceFirst(':consultId', controller.consultId.value);
              Get.toNamed(
                route,
                arguments: {
                  'consultName': controller.consultName.value,
                  'consultDuration': controller.consultDuration.value,
                  'consultPrice': controller.consultPrice.value,
                  'professionalName':
                      professionalAvailability.professional.name,
                  'selectedTime': formattedTime,
                  'selectedDate': controller.selectedDate.value,
                  'consultId': controller.consultId.value,
                  'professionalId': professionalAvailability.professional.id,
                  'organizationId': controller.organizationId.value,
                },
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey[900],
              side: const BorderSide(color: AppColors.main),
              padding: EdgeInsets.zero,
            ),
            child: Center(
              child: Text(
                formattedTime,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }
}
