import 'package:blood_donation_app/app/data/seassion/auth_seassion.dart';
import 'package:blood_donation_app/app/data/services/AuthServices.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initialConfig();
  }

  Future<void> initialConfig() async {

    // ১. প্রথমে ইন্টারনেট চেক করবে
    bool isConnected = await checkInternet();

    if (!isConnected) {
      // ইন্টারনেট না থাকলে মেসেজ দিবে এবং আবার চেক করার জন্য অপেক্ষা করবে
      Get.snackbar(
        "No Internet",
        "দয়া করে আপনার ইন্টারনেট কানেকশন চালু করুন",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );

      await Future.delayed(const Duration(seconds: 3));
      initialConfig(); // পুনরায় চেক করার জন্য রিকাসিভ কল
      return;
    }

    // ২. ইন্টারনেট থাকলে অথ চেক করবে
    await checkAuth();
  }

  Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> checkAuth() async {
    AuthSeassion authSeassion = AuthSeassion();
    final token = await authSeassion.getToken();

    final AuthServices services = AuthServices();

    // যদি টোকেন না থাকে সরাসরি WELCOME পেজে যাবে
    if (token == null || token.isEmpty) {
      await Future.delayed(const Duration(seconds: 2));
      Get.offAllNamed(Routes.WELCOME);
      return;
    }

    try {
      // সার্ভার থেকে প্রোফাইল ডাটা চেক করা হচ্ছে
      var response = await services.profile();

      // যদি রেসপন্স সাকসেসফুল হয় (আপনার API অনুযায়ী চেক করবেন)
      if (response != null) {
        Get.offAllNamed(Routes.BOTTOM_NAV);
      } else {
        throw Exception("Invalid Token");
      }
    } catch (e) {
      // টোকেন এক্সপায়ার হলে বা কোনো এরর হলে লগআউট করে ওয়েলকামে পাঠাবে
      await authSeassion.logout();
      Get.offAllNamed(Routes.WELCOME);
    }
  }


}