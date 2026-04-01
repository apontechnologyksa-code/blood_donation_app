import 'package:get/get.dart';

import '../controllers/donation_tips_controller.dart';

class DonationTipsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DonationTipsController>(
      () => DonationTipsController(),
    );
  }
}
