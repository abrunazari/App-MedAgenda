import 'package:app_medagenda/features/appointments/ui/controllers/clinic-details-controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClinicDetailsController>();
    return Obx(() => SliverAppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/shape-colors.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                backgroundImage: controller.clinicEntity.value?.imageUrl != null
                    ? NetworkImage(controller.clinicEntity.value!.imageUrl!)
                    : const AssetImage("images/standalone-logo.png")
                        as ImageProvider,
              ),
              const SizedBox(width: 10),
              Text(controller.clinicEntity.value?.name ?? '',
                  style: const TextStyle(fontSize: 20, color: Colors.white)),
            ],
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          floating: true,
          snap: true,
        ));
  }
}
