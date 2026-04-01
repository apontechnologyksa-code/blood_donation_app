import 'package:get/get.dart';

import '../controllers/change_themes_controller.dart';

class ChangeThemesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChangeThemesController());
  }
}
