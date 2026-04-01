import 'package:get/get.dart';

import '../../../data/model/donor.dart';
import '../../../data/services/DonorServices.dart';

class DonorsSearchController extends GetxController {


  var donors = <Donors>[].obs;
  var isLoading = false.obs;
  var selectedGroup = 'A+'.obs;

  final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  final DonorServices donorService = DonorServices();


  var selectedDivision = ''.obs;
  var selectedDistrict = ''.obs;
  var selectedUpazila = ''.obs;


  @override
  void onInit() {
    fetchDonorsBlood(selectedGroup.value);
    super.onInit();
  }

  void fetchDonorsBlood(String group) async {
    try {
      isLoading.value = true;
      final result = await DonorServices.getDonorsByBlood(group);
      donors.value = result;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void changeGroup(String group) {
    selectedGroup.value = group;
    fetchDonorsBlood(group);
  }



}