import 'package:get/get.dart';

import '../controllers/location_search_tab_controller.dart';

class LocationSearchTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LocationSearchTabController());
  }
}
