import 'package:app_medagenda/features/appointments/domain/entities/clinic.entity.dart';
import 'package:app_medagenda/features/appointments/domain/usecases/get-clinic-info.usecase.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class ClinicDetailsController extends GetxController {
  final GetClinicInfoUsecase getClinicInfoUsecase;

  ClinicDetailsController({
    required this.getClinicInfoUsecase,
  });

  final clinicEntity = Rx<ClinicEntity?>(null);
  final errorMessage = Rx<String?>(null);
  final isLoading = false.obs;

  final RxString organizationId = ''.obs;
  final availableDates = RxList<String>([]);
  final selectedDate = RxString('');

  final GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    organizationId.value = Get.parameters['clinicId'] ?? '';
    if (organizationId.value.isEmpty) {
      errorMessage.value = 'Nenhum clinicId fornecido';
      return;
    }
    initializeAvailableDates();

    clearStoredData();
    getClinicInfo(organizationId.value);
  }

  void initializeAvailableDates() {
    final now = DateTime.now();
    availableDates.value = List.generate(
      30,
      (index) =>
          DateFormat('yyyy-MM-dd').format(now.add(Duration(days: index))),
    );
  }

  void clearStoredData() {
    box.erase();
  }

  void getClinicInfo(String clinicId) async {
    if (clinicId.isEmpty) {
      errorMessage.value = 'Nenhum clinicId fornecido';
      return;
    }
    isLoading.value = true;

    final result = await getClinicInfoUsecase
        .call(GetClinicInfoParams(clinicId: clinicId));
    isLoading.value = false;

    result.fold((failure) {
      errorMessage.value = failure.message;
    }, (clinic) {
      clinicEntity.value = clinic;
      errorMessage.value = null;
    });
  }
}
