import 'package:get/get.dart';

import '../controllers/blood_group_search_tab_controller.dart';

class BloodGroupSearchTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BloodGroupSearchTabController());
  }
}
