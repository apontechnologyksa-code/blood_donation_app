import 'dart:convert';
import 'package:blood_donation_app/app/data/helpers/app_snackbar.dart';
import 'package:blood_donation_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/blood_services.dart';
import '../../myBloodPost/controllers/my_blood_post_controller.dart';

class PostBloodController extends GetxController {
  final bloodGroups = const ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"];

  final typeGroups = const ["জরুরি", "সফল"];

  final selectedBlood = RxnString();
  final selectedType = RxnString();

  var selectedDate = Rxn<DateTime>();
  var selectedTime = Rxn<TimeOfDay>();

  final BloodServices services = BloodServices();
  final RxBool isLoading = false.obs;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final hospitalController = TextEditingController();
  final locationController = TextEditingController();
  final unitsController = TextEditingController();
  final reasonController = TextEditingController();
  final descriptionController = TextEditingController();

  final MyBloodPostController myBloodPostController = Get.put(
    MyBloodPostController(),
  );

  final HomeController homeController = Get.put(HomeController());

  void pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  void pickTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value ?? TimeOfDay.now(),
    );

    if (picked != null) {
      selectedTime.value = picked;
    }
  }

  Future<void> bloodPost() async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    try {
      isLoading.value = true;

      final hour = selectedTime.value!.hour;
      final minute = selectedTime.value!.minute;
      final formattedTime =
          "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:00";

      final postData = {
        "name": nameController.text.trim(),
        "phone": phoneController.text.trim(),
        "hospital": hospitalController.text.trim(),
        "location": locationController.text.trim(),
        "unit": unitsController.text.trim(),
        "reason": reasonController.text.trim(),
        "description": descriptionController.text.trim(),
        "blood_group": selectedBlood.value,
        "status": selectedType.value,
        "date": selectedDate.value!.toIso8601String().split("T")[0],
        "time": formattedTime,
      };

      final response = await services.bloodPostCreate(postData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = jsonDecode(response.body);
        if (result['status'] == true || response.statusCode == 201) {
          Get.back();

          myBloodPostController.getBloodPost();
          homeController.getBloodRequestFivePosts();

          showAppSnackbar(
            title: "সফল",
            message: "আপনার পোস্টটি সফলভাবে পাবলিশ হয়েছে",
          );
        }
      } else {
        showAppSnackbar(
          title: "ব্যর্থ",
          message: "সার্ভারে সমস্যা হয়েছে। আবার চেষ্টা করুন।",
          isError: true,
        );
      }
    } catch (e) {
      debugPrint("bloodPost error: $e");
      showAppSnackbar(
        title: "ত্রুটি",
        message: "কিছু একটা ভুল হয়েছে। ইন্টার কানেকশন চেক করুন।",
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    hospitalController.dispose();
    locationController.dispose();
    unitsController.dispose();
    reasonController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
