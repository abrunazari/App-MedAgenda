import 'package:app_medagenda/features/appointments/domain/entities/clinic.entity.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClinicDetailsController extends GetxController {
  final AppointmentService _barberShopInfosService =
      Get.find<AppointmentService>();

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
    organizationId.value = Get.parameters['companyId'] ?? '';
    if (organizationId.value.isEmpty) {
      errorMessage.value = 'Nenhum CompanyId fornecido';
      return;
    }
    clearStoredData();

    getBarberShopInfo(organizationId.value);
  }

  void clearStoredData() {
    box.erase();
  }

  void getBarberShopInfo(String companyId) async {
    var companyId = Get.parameters['companyId'];

    if (companyId == null) {
      errorMessage.value = 'Nenhum CompanyId fornecido';
      return;
    }
    isLoading.value = true;
    final result = await _barberShopInfosService.getBarberShopInfos(
        barberShopId: companyId);
    isLoading.value = false;

    result.fold((failure) {
      errorMessage.value = failure.message;
    }, (barberShop) {
      clinicEntity.value = barberShop;
      errorMessage.value = null;
    });
  }
}
