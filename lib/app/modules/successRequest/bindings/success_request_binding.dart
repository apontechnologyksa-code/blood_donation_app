import 'package:get/get.dart';

import '../controllers/success_request_controller.dart';

class SuccessRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SuccessRequestController());
  }
}
