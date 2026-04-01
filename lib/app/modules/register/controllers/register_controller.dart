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
      if (!(formKey.currentState?.validate() ?? false)) return;

      isLoading.value = true;

      final Map<String, dynamic> userData = {
        "name": nameController.text.trim(),
        "phone": phoneController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text,
        "blood": selectedBlood.value!,
        "user_type": selectedUserType.value,
      };

      final response = await authServices.register(userData);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = result['token'];
        authSeassion.saveToken(token);

        showAppSnackbar(title: "সফল", message: "সফলভাবে নিবন্ধন হয়েছে");
        Get.offAllNamed(Routes.LOGIN);
      } else if (response.statusCode == 422) {
        print(result);
        showAppSnackbar(

          title: "ত্রুটি",
          message: result["message"],
          isError: true,
        );
      } else {
        showAppSnackbar(
          title: "ত্রুটি",
          message: "Something went wrong : ${response.statusCode}",
          isError: true,
        );
      }
    } catch (e) {
      showAppSnackbar(
        title: "ত্রুটি",
        message: "Something went wrong $e ",
        isError: true,
      );
    } finally {
      isLoading.value = false;
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
  }
}
