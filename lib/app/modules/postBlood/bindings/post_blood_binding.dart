import 'package:get/get.dart';

import '../controllers/post_blood_controller.dart';

class PostBloodBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PostBloodController());
  }
}
