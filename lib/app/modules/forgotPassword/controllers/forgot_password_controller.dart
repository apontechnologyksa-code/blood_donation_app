import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/helpers/app_snackbar.dart';
import '../../../data/services/forgot_password_service.dart';
import '../../../routes/app_pages.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();

  var isLoading = false.obs;

  final ForgotPasswordService _service = ForgotPasswordService();

  Future<void> sendOtp() async {
    if (emailController.text.isEmpty) {
      showAppSnackbar(
        title: 'ত্রুটি',
        message: 'আপনার ইমেইল দেন',
        isError: true,
      );
      return;
    }

    final email = emailController.text.trim();

    try {
      isLoading.value = true;
      await _service.forgotPassword(email);

      final pref = await SharedPreferences.getInstance();
      bool success = await pref.setString('email', email);

      showAppSnackbar(
        title: 'সফল',
        message: 'পাসওয়ার্ড রিসেটের জন্য একটি ওটিপি পাঠানো হয়েছে',
      );
      Get.toNamed(Routes.VERIFY_OTP);
    } catch (e) {
      Get.snackbar('Error', e.toString());
      showAppSnackbar(title: 'ত্রুটি', message: e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }
}
