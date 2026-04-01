import 'package:get/get.dart';

import '../controllers/sasto_tips_controller.dart';

class SastoTipsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SastoTipsController>(
      () => SastoTipsController(),
    );
  }
}
