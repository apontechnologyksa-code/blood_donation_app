import 'dart:convert';

import 'package:blood_donation_app/app/data/seassion/auth_seassion.dart';
import 'package:blood_donation_app/app/data/services/AuthServices.dart';
import 'package:blood_donation_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/helpers/app_snackbar.dart';

class RegisterController extends GetxController {
  final AuthServices authServices = AuthServices();
  final AuthSeassion authSeassion = AuthSeassion();

  final bloodGroups = const [
    "এ+",
    "এ-",
    "বি+",
    "বি-",
    "ও+",
    "ও-",
    "এবি+",
    "এবি-",
  ];

  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final selectedBlood = RxnString();
  final selectedUserType = "user".obs;

  var isLoading = false.obs;

  Future<void> register() async {
    try {
      print("🚀 Register function started");

      if (!(formKey.currentState?.validate() ?? false)) {
        print("❌ Form validation failed");
        return;
      }

      /// Blood group check
      if (selectedBlood.value == null) {
        showAppSnackbar(
          title: "ত্রুটি",
          message: "রক্তের গ্রুপ নির্বাচন করুন",
          isError: true,
        );
        return;
      }

      isLoading.value = true;
      print("⏳ Loading started");

      /// Request Data
      final Map<String, dynamic> userData = {
        "name": nameController.text.trim(),
        "phone": phoneController.text.trim().isEmpty
            ? null
            : phoneController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text,
        "blood": selectedBlood.value,
        "user_type": selectedUserType.value,
      };

      print("📦 User Data: $userData");

      /// API Call
      final response = await authServices.register(userData);

      print("📡 Status Code: ${response.statusCode}");
      print("📡 Response Body: ${response.body}");

      final result = jsonDecode(response.body);

      /// ================= SUCCESS =================
      if (response.statusCode == 200 ||
          response.statusCode == 201) {

        final token = result['token'];
        final user = result['user'];

        print("🔑 Token received: $token");
        print("👤 User: $user");

        /// Token check
        if (token == null || token.toString().isEmpty) {
          throw Exception("Token not found in response");
        }

        /// Save token
        await authSeassion.saveToken(token);

        showAppSnackbar(
          title: "সফল",
          message:
          result['message'] ?? "সফলভাবে নিবন্ধন হয়েছে",
        );

        print("✅ Registration success");

        /// Navigate
        Get.offAllNamed(Routes.LOGIN);
      }

      /// ================= VALIDATION ERROR =================
      else if (response.statusCode == 422) {

        print("⚠️ Validation error: $result");

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

      /// ================= OTHER ERROR =================
      else {

        print("❌ Unknown error: ${response.statusCode}");

        showAppSnackbar(
          title: "ত্রুটি",
          message: result['message'] ??
              "Something went wrong : ${response.statusCode}",
          isError: true,
        );
      }
    } catch (e) {

      print("🔥 Exception: $e");

      showAppSnackbar(
        title: "ত্রুটি",
        message: "Something went wrong : $e",
        isError: true,
      );
    } finally {

      isLoading.value = false;

      print("⛔ Loading stopped");
    }
  }











  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "নাম লিখুন";
    }
    if (value.trim().length < 3) {
      return "কমপক্ষে ৩ অক্ষরের নাম লিখুন";
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "নাম্বার লিখুন";
    }
    if (!GetUtils.isPhoneNumber(value.trim())) {
      return "সঠিক নাম্বার লিখুন";
    }
    if (value.trim().length != 11) {
      return "১১ সংখ্যার নাম্বার লিখুন";
    }
    return null;
  }

  String? validateBlood(String? value) {
    if (value == null) {
      return "রক্তের গ্রুপ নির্বাচন করুন";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "জিমেইল একাউন্ট লিখুন";
    }
    if (!GetUtils.isEmail(value.trim())) {
      return "সঠিক ইমেইল লিখুন";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "আপনার পাসওয়ার্ড লিখুন";
    }
    if (value.length < 6) {
      return "পাসওয়ার্ড কমপক্ষে ৬ অক্ষরের হতে হবে";
    }
    return null;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void clearFrom() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    passwordController.clear();

    print("🧹 Form cleared");
  }
}