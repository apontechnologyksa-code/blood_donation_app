import 'package:get/get.dart';

import '../../../data/model/donor.dart';
import '../../../data/services/DonorServices.dart';

class BloodGroupSearchTabController extends GetxController {
  var donors = <Donors>[].obs;
  var isLoading = false.obs;
  var selectedGroup = 'এ+'.obs;

  final bloodGroups = const [
    "এ+",
    "এ-",
    "বি+",
    "বি-",
    "ও+",
    "ও-",
    "এবি+",
    "এবি-",
  ];

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
