import 'package:get/get.dart';

import '../controllers/my_blood_post_controller.dart';

class MyBloodPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MyBloodPostController());
  }
}
