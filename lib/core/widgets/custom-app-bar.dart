import 'package:app_medagenda/features/appointments/ui/controllers/clinic-details-controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<
        ClinicDetailsController>(); //"ClinicDetailsController" not found. You need to call "Get.put(ClinicDetailsController())" or "Get.lazyPut(()=>ClinicDetailsController())"
    return Obx(() => SliverAppBar(
          backgroundColor: const Color(0xFF147190),
          title: Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage("assets/images/logo.png"),
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
