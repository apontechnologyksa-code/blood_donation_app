import 'dart:convert';

import 'package:blood_donation_app/app/data/helpers/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/services/forgot_password_service.dart';
import '../../../routes/app_pages.dart';

class VerifyOtpController extends GetxController {
  final ForgotPasswordService service = ForgotPasswordService();

  var isLoading = false.obs;
  final emailController = TextEditingController();
  final otpController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadSavedEmail();
  }

  void loadSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('email');
    if (savedEmail != null) {
      emailController.text = savedEmail;
    }
  }

  void verifyOtp() async {
    final email = emailController.text.trim();
    final otp = otpController.text.trim();

    if (email.isEmpty || otp.isEmpty) {
      showAppSnackbar(
        title: "ভুল হয়েছে",
        message: email.isEmpty
            ? "ইমেইল ঠিকানাটি প্রয়োজন"
            : "অনুগ্রহ করে ওটিপি কোডটি লিখুন",
        isError: true,
      );
      return;
    }

    try {
      isLoading.value = true;
      final response = await service.verifyOtp(email, otp);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        if (result['success'] == true || result['message'] == "OTP verified") {
          showAppSnackbar(
            title: "সফল হয়েছে",
            message: "ওটিপি সফলভাবে যাচাই করা হয়েছে",
          );

          Get.toNamed(Routes.RESET_PASSWORD, arguments: {'email': email});
        } else if (result['message'] == "Invalid OTP") {
          showAppSnackbar(
            title: "সমস্যা হয়েছে",
            message: result['message'] ?? "ওটিপি সঠিক নয়, আবার চেষ্টা করুন",
            isError: true,
          );
        }
      } else {
        showAppSnackbar(
          title: "সমস্যা হয়েছে",
          message: "ওটিপি সঠিক নয়, আবার চেষ্টা করুনা",
          isError: true,
        );
      }
    } catch (e) {
      showAppSnackbar(
        title: "সমস্যা হয়েছে",
        message: "ইন্টারনেট সংযোগ বা অন্য কোনো সমস্যা হয়েছে।",
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    otpController.dispose();
    super.onClose();
  }
}
