import 'dart:convert';

import 'package:blood_donation_app/app/data/model/user.dart';
import 'package:blood_donation_app/app/data/services/AuthServices.dart';
import 'package:get/get.dart';

import '../../../data/helpers/app_snackbar.dart';
import '../../../data/seassion/auth_seassion.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final AuthServices services = AuthServices();

  final isLoading = false.obs;

  final userData = User().obs;

  @override
  void onInit() {
    profile();
    super.onInit();
  }

  Future<void> profile() async {
    try {
      isLoading.value = true;
      final response = await services.profile();

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        final user = result['user'];

        userData.value = User.fromJson(user);
      } else if (response.statusCode == 401) {
        showAppSnackbar(
          title: "ত্রুটি",
          message: "আবার লগইন করুন",
          isError: true,
        );
      } else {
        showAppSnackbar(
          title: "ত্রুটি",
          message: "কিছু সমস্যা হয়েছে : ${response.statusCode}",
          isError: true,
        );
      }
    } catch (e) {
      throw Exception("Something went wrong : $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    AuthSeassion authSeassion = AuthSeassion();
    await authSeassion.logout();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> deleteAccount() async {
    try {
      isLoading.value = true;

      final response = await services.delete();

      if (response.statusCode == 200) {
        showAppSnackbar(title: "সফল", message: "অ্যাকাউন্ট মুছে ফেলা হয়েছে");
        Get.offAllNamed(Routes.LOGIN);
      } else {
        showAppSnackbar(
          title: "কিছু সমস্যা হয়েছে",
          message: "${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
