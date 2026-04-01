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
      if (emailController.text.isEmpty) {
        showAppSnackbar(title: "ত্রুটি", message: "ইমেইল লিখুন", isError: true);
        return;
      }

      if (passwordController.text.isEmpty) {
        showAppSnackbar(
          title: "ত্রুটি",
          message: "পাসওয়ার্ড লিখুন",
          isError: true,
        );
        return;
      }

      isLoading.value = true;

      final loginData = {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      };

      final response = await authServices.login(loginData);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final token = result['token'];
        authSeassion.saveToken(token);
        showAppSnackbar(title: "সফল", message: "সফলভাবে লগইন হয়েছে");
        Get.offAllNamed(Routes.BOTTOM_NAV);
      } else if (response.statusCode == 422) {
        showAppSnackbar(
          title: "ত্রুটি",
          message: result['message'],
          isError: true,
        );
      } else {
        showAppSnackbar(
          title: "ত্রুটি",
          message: result['message'],
          isError: true,
        );
      }
    } catch (e) {
      showAppSnackbar(
        title: "ত্রুটি",
        message: "কিছু সমস্যা হয়েছে",
        isError: true,
      );
      throw Exception("$e");
    } finally {
      isLoading.value = false;
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
