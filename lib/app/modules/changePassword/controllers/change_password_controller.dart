import 'dart:convert';

import 'package:blood_donation_app/app/data/services/AuthServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/helpers/app_snackbar.dart';

class ChangePasswordController extends GetxController {
  final AuthServices services = AuthServices();
  final isLoading = false.obs;

  final oldController = TextEditingController();
  final newController = TextEditingController();
  final confirmController = TextEditingController();

  Future<void> changePassword() async {
    try {
      if (oldController.text.isEmpty) {
        showAppSnackbar(
          isError: true,
          title: "কিছু সমস্যা হয়েছে",
          message: "পুরাতন পাসওয়ার্ড প্রয়োজন",
        );
        return;
      }

      if (newController.text.isEmpty) {
        showAppSnackbar(
          isError: true,
          title: "কিছু সমস্যা হয়েছে",
          message: "নতুন পাসওয়ার্ড প্রয়োজন",
        );
        return;
      }

      if (confirmController.text.isEmpty) {
        showAppSnackbar(
          isError: true,
          title: "কিছু সমস্যা হয়েছে",
          message: "নিশ্চিতকরণ পাসওয়ার্ড প্রয়োজন",
        );
        return;
      }

      if (newController.text != confirmController.text) {
        showAppSnackbar(
          isError: true,
          title: "কিছু সমস্যা হয়েছে",
          message: "নতুন পাসওয়ার্ড এবং নিশ্চিতকরণ পাসওয়ার্ড মেলেনি",
        );
        return;
      }

      print(
        "Old :  ${oldController.text}  New ${newController.text}  Confirm ${confirmController.text}",
      );

      isLoading.value = true;

      final response = await services.changePassword({
        "current_password": oldController.text.trim(),
        "new_password": newController.text.trim(),
        "new_password_confirmation": confirmController.text.trim(),
      });
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        showAppSnackbar(
          isError: false,
          title: "সাফল্য",
          message: "পাসওয়ার্ড সফলভাবে পরিবর্তন হয়েছে",
        );
        oldController.clear();
        newController.clear();
        confirmController.clear();
      } else {
        print("${response.statusCode} ${result['message']}");
        showAppSnackbar(
          isError: true,
          title: "কিছু সমস্যা হয়েছে",
          message: result['message'],
        );
      }
    } catch (e) {
      print(e.toString());
      showAppSnackbar(isError: true, title: "এক্সসেপশন", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
