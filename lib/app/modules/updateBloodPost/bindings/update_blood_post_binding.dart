import 'package:get/get.dart';

import '../controllers/update_blood_post_controller.dart';

class UpdateBloodPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UpdateBloodPostController());
  }
}
