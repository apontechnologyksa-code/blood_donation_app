import 'package:get/get.dart';

import '../controllers/donors_details_controller.dart';

class DonorsDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DonorsDetailsController());
  }
}
