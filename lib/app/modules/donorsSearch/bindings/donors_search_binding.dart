import 'package:get/get.dart';

import '../controllers/donors_search_controller.dart';

class DonorsSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DonorsSearchController>(
      () => DonorsSearchController(),
    );
  }
}
