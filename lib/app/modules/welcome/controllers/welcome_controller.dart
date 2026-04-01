import 'package:blood_donation_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  void goToLoginScreen() {
    Get.toNamed(Routes.LOGIN);
  }

  void goToRegisterScreen() {
    Get.toNamed(Routes.REGISTER);
  }
}
