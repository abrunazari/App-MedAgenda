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

  final organizationId = ''.obs;
  final availableDates = RxList<String>([]);
  final selectedDate = ''.obs;

  final GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadOrganizationId();
    if (organizationId.isEmpty) {
      errorMessage.value = 'Nenhum clinicId fornecido';
      return;
    }
    initializeAvailableDates();
    clearStoredData();
    fetchClinicInfo();
  }

  void loadOrganizationId() {
    organizationId.value = Get.parameters['clinicId'] ?? '';
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

  Future<void> fetchClinicInfo() async {
    isLoading.value = true;
    final result = await getClinicInfoUsecase
        .call(GetClinicInfoParams(clinicId: organizationId.value));
    isLoading.value = false;

    result.fold(
      (failure) {
        errorMessage.value = failure.message;
      },
      (clinic) {
        clinicEntity.value = clinic;
        errorMessage.value = null;
      },
    );
  }
}
