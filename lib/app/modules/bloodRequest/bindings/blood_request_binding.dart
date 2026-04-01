import 'package:get/get.dart';

import '../controllers/blood_request_controller.dart';

class BloodRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BloodRequestController());
  }
}
