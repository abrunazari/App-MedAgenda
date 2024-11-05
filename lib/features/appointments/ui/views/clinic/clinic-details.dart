import 'package:app_medagenda/core/constants/color.dart';
import 'package:app_medagenda/core/utils/format-currency.dart';
import 'package:app_medagenda/core/utils/format-duration.dart';
import 'package:app_medagenda/core/widgets/layout.dart';
import 'package:app_medagenda/features/appointments/domain/entities/consult.entity.dart';
import 'package:app_medagenda/features/appointments/ui/controllers/clinic-details-controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClinicDetailsContainer extends GetView<ClinicDetailsController> {
  const ClinicDetailsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Serviços",
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (controller.errorMessage.value != null) {
        return Center(
          child: Container(),
        );
      } else if (controller.clinicEntity.value == null ||
          controller.clinicEntity.value!.categories.isEmpty ||
          controller.clinicEntity.value!.categories
              .every((category) => category.consults.isEmpty)) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Nenhum serviço disponível',
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      } else {
        var barberShop = controller.clinicEntity.value;
        return CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  var category = barberShop!.categories[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                category.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.main,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            children: [
                              ...category.consults.map((service) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: ListTile(
                                    title: Text(
                                      service.name,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    subtitle: Text(
                                      formatDuration(service.durationInMinutes),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    trailing: Text(
                                      'R\$${formatCurrency(service.value)}',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    onTap: () => showDateSelectionPopup(
                                        context, service),
                                  ),
                                );
                              }).toList(),
                              const SizedBox(height: 16.0),
                              const Divider(height: 1),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: barberShop?.categories.length ?? 0,
              ),
            ),
          ],
        );
      }
    });
  }

  void showDateSelectionPopup(
      BuildContext context, ConsultEntity selectedConsult) async {
    // final ThemeData themeData = Theme.of(context);
    // final DateTime? picked = await showDatePicker(
    //   locale: const Locale("pt", "BR"),
    //   context: context,
    //   initialDate: DateTime.now(),
    //   firstDate: DateTime.now(),
    //   lastDate: DateTime(2100),
    //   helpText: 'Selecione uma data',
    //   builder: (BuildContext context, Widget? child) {
    //     return Theme(
    //       data: ThemeData.light().copyWith(
    //         colorScheme: themeData.colorScheme.copyWith(
    //           primary: AppColors.main,
    //         ),
    //         dialogTheme: const DialogTheme(
    //           titleTextStyle: TextStyle(
    //             fontSize: 24,
    //             color: AppColors.main,
    //           ),
    //         ),
    //       ),
    //       child: child!,
    //     );
    //   },
    // );

    // if (picked != null) {
    //   final dateTZ = tz.TZDateTime.from(picked, tz.local);
    //   String formattedDate = dateTZ.toIso8601String();

    //   String route = Routes.CONSULT_DETAILS
    //       .replaceAll(':companyId', controller.organizationId.value)
    //       .replaceAll(':serviceId', selectedConsult.id);

    //   Get.toNamed(
    //     route,
    //     parameters: {'selectedDate': formattedDate},
    //   );

    //   if (!controller.availableDates
    //       .contains(DateFormat('yyyy-MM-dd').format(picked))) {
    //     controller.availableDates.add(DateFormat('yyyy-MM-dd').format(picked));
    //   }

    //   controller.selectedDate.value = formattedDate;
    // }
  }
}
