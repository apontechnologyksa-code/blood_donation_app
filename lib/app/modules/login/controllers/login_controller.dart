import 'dart:convert';
import 'package:blood_donation_app/app/data/helpers/app_snackbar.dart';
import 'package:blood_donation_app/app/data/seassion/auth_seassion.dart';
import 'package:blood_donation_app/app/data/services/AuthServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final AuthSeassion authSeassion = AuthSeassion();
  final AuthServices authServices = AuthServices();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;

  Future<void> login() async {
    try {
      print("🚀 Login function started");

      /// Email validation
      if (emailController.text.trim().isEmpty) {
        print("❌ Email is empty");

        showAppSnackbar(
          title: "ত্রুটি",
          message: "ইমেইল লিখুন",
          isError: true,
        );
        return;
      }

      /// Password validation
      if (passwordController.text.trim().isEmpty) {
        print("❌ Password is empty");

        showAppSnackbar(
          title: "ত্রুটি",
          message: "পাসওয়ার্ড লিখুন",
          isError: true,
        );
        return;
      }

      isLoading.value = true;

      print("⏳ Loading started");

      /// Request body
      final loginData = {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      };

      print("📦 Login Data: $loginData");

      /// API Call
      final response = await authServices.login(loginData);

      print("📡 Status Code: ${response.statusCode}");
      print("📡 Response Body: ${response.body}");

      final result = jsonDecode(response.body);

      /// ================= SUCCESS =================
      if (response.statusCode == 200) {

        final token = result['token'];
        final user = result['user'];

        print("🔑 Token: $token");
        print("👤 User: $user");

        /// Token validation
        if (token == null || token.toString().isEmpty) {
          throw Exception("Token not found");
        }

        /// Save token
        await authSeassion.saveToken(token);

        print("✅ Token saved");

        showAppSnackbar(
          title: "সফল",
          message: result['message'] ?? "সফলভাবে লগইন হয়েছে",
        );

        print("✅ Login successful");

        /// Navigate
        Get.offAllNamed(Routes.BOTTOM_NAV);
      }

      /// ================= VALIDATION ERROR =================
      else if (response.statusCode == 422) {

        print("⚠️ Validation Error: $result");

        String errorMessage = "";

        if (result["errors"] != null) {

          result["errors"].forEach((key, value) {
            errorMessage += "${value[0]}\n";
          });

        } else {

          errorMessage =
              result['message'] ?? "Validation error";
        }

        showAppSnackbar(
          title: "ত্রুটি",
          message: errorMessage.trim(),
          isError: true,
        );
      }

      /// ================= LOGIN FAILED =================
      else if (response.statusCode == 401) {

        print("❌ Unauthorized Login");

        showAppSnackbar(
          title: "ত্রুটি",
          message:
          result['message'] ??
              "ইমেইল অথবা পাসওয়ার্ড ভুল",
          isError: true,
        );
      }

      /// ================= OTHER ERROR =================
      else {

        print("❌ Unknown Error");

        showAppSnackbar(
          title: "ত্রুটি",
          message:
          result['message'] ??
              "Something went wrong",
          isError: true,
        );
      }
    } catch (e) {

      print("🔥 Exception: $e");

      showAppSnackbar(
        title: "ত্রুটি",
        message: "কিছু সমস্যা হয়েছে",
        isError: true,
      );
    } finally {

      isLoading.value = false;

      print("⛔ Loading stopped");
    }
  }


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void clearFrom() {
    emailController.clear();
    passwordController.clear();
  }
}
