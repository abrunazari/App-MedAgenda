import 'package:app_medagenda/features/appointments/domain/entities/consult.entity.dart';
import 'package:app_medagenda/features/appointments/domain/entities/professional-availability.entity.dart';
import 'package:app_medagenda/features/appointments/domain/usecases/get-consult-info.usecase.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class ConsultDetailsController extends GetxController {
  final GetConsultInfoUsecase getConsultInfoUsecase;

  ConsultDetailsController({
    required this.getConsultInfoUsecase,
  });

  final Rx<ConsultAvailability?> consultAvailability =
      Rxn<ConsultAvailability>();
  final selectedDate = RxString('');
  final availableDates = RxList<String>([]);
  final consultName = RxString('');
  final consultDuration = RxInt(0);
  final consultPrice = RxInt(0);
  final professionals = RxList<ProfessionalAvailability>([]);

  final consultId = RxString('');
  final RxString organizationId = ''.obs;
  final RxBool isLoading = false.obs;
  final GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();

    organizationId.value = Get.parameters['clinicId'] ?? '';
    consultId.value = Get.parameters['consultId'] ?? '';

    String? selectedDateArg =
        Get.parameters['selectedDate'] ?? DateTime.now().toIso8601String();
    if (consultId.value.isNotEmpty) {
      selectedDate.value = selectedDateArg;
      fetchConsultAndProfessionals(consultId.value, selectedDateArg);
    }

    clearStoredData();
  }

  void clearStoredData() {
    box.erase();
  }

  void fetchConsultAndProfessionals(String consultId, String date) async {
    isLoading.value = true;

    final result = await getConsultInfoUsecase
        .call(GetConsultInfoParams(consultId: consultId, date: date));
    isLoading.value = false;

    result.fold((failure) {
      print(failure);
    }, (consultAvailabilityData) {
      selectedDate.value = date;
      consultAvailability.value = consultAvailabilityData;

      availableDates.value = consultAvailabilityData.availableDates
          .map((date) => DateFormat('yyyy-MM-dd').format(date))
          .toList();
      consultName.value = consultAvailabilityData.consults.name;
      consultDuration.value = consultAvailabilityData.consults.duration;
      consultPrice.value = consultAvailabilityData.consults.price.toInt();
      professionals.value = consultAvailabilityData.availableProfessionals;

      if (!availableDates.contains(DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(selectedDate.value)))) {
        availableDates.add(DateFormat('yyyy-MM-dd')
            .format(DateTime.parse(selectedDate.value)));
      }
    });
  }

  void handleDateSelection(String formattedDate) {
    selectedDate.value = formattedDate;
    box.write('selectedDate', formattedDate);
    fetchConsultAndProfessionals(consultId.value, formattedDate);
  }
}
