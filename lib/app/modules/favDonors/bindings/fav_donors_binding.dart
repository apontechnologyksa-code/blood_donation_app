import 'package:get/get.dart';

import '../controllers/fav_donors_controller.dart';

class FavDonorsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FavDonorsController());
  }
}
