import 'package:blood_donation_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/helpers/app_snackbar.dart';
import '../../../data/services/forgot_password_service.dart';

class ResetPasswordController extends GetxController {
  var isLoading = false.obs;

  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  final ForgotPasswordService service = ForgotPasswordService();

  void resetPassword() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('email');

    final password = passwordController.text.trim();
    final passwordConfirmation = passwordConfirmationController.text.trim();

    if (password.isEmpty || passwordConfirmation.isEmpty) {
      showAppSnackbar(
        title: "ভুল হয়েছে",
        message: "আপনার পাসওয়ার্ড দেন",
        isError: true,
      );

      return;
    }

    if (password != passwordConfirmation) {
      showAppSnackbar(
        title: "ভুল হয়েছে",
        message: "পাসওয়ার্ড মিলছে না।",
        isError: true,
      );

      return;
    }

    try {
      isLoading.value = true;

      await service.resetPassword(
        savedEmail!,
        passwordController.text.trim(),
        passwordConfirmationController.text.trim(),
      );

      isLoading.value = false;

      showAppSnackbar(title: "সফল", message: "পাসওয়ার্ড রিসেট সফল হয়েছে");

      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      isLoading.value = false;

      showAppSnackbar(
        title: "ভুল হয়েছে",
        message: e.toString(),
        isError: true,
      );
    }
  }
}
