import 'package:app_medagenda/core/bindings/initial.dart';
import 'package:app_medagenda/core/constants/color.dart';
import 'package:app_medagenda/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  GetStorage.init();
  InitialBinding().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!),
      title: 'MedAgenda',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.main),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      getPages: Pages.pages,
      initialRoute: Routes.CLINIC,
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
    );
  }
}
