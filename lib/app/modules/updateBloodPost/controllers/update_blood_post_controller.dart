import 'dart:convert';

import 'package:blood_donation_app/app/data/model/post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/helpers/app_snackbar.dart';
import '../../../data/services/blood_services.dart';
import '../../myBloodPost/controllers/my_blood_post_controller.dart';

class UpdateBloodPostController extends GetxController {
  final bloodGroups = const ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"];
  final selectedBlood = RxnString();

  final typeGroups = const ["জরুরি", "সফল"];
  final selectedType = RxnString();

  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;

  final BloodServices services = BloodServices();
  final RxBool isLoading = false.obs;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final hospitalController = TextEditingController();
  final locationController = TextEditingController();
  final unitsController = TextEditingController();
  final reasonController = TextEditingController();
  final descriptionController = TextEditingController();

  final Post? post = Get.arguments;

  final MyBloodPostController myBloodPostController =
  Get.put(MyBloodPostController());

  @override
  void onInit() {
    super.onInit();

    if (post != null) {
      loadData();
    }
  }

  void loadData() {
    nameController.text = post?.name ?? "";
    phoneController.text = post?.phone ?? "";
    hospitalController.text = post?.hospital ?? "";
    locationController.text = post?.location ?? "";
    unitsController.text = post?.unit?.toString() ?? "";
    reasonController.text = post?.reason ?? "";
    descriptionController.text = post?.description ?? "";

    selectedBlood.value = post?.bloodGroup;
    selectedType.value = post?.status;

    if (post?.date != null) {
      selectedDate.value = DateTime.parse(post!.date!);
    }
  }

  void updateBloodPost() async {

    /// ---------- Validation ----------

    if (nameController.text.trim().isEmpty) {
      showAppSnackbar(
        title: "সতর্কতা",
        message: "নাম লিখুন",
        isError: true,
      );
      return;
    }

    if (phoneController.text.trim().isEmpty) {
      showAppSnackbar(
        title: "সতর্কতা",
        message: "ফোন নম্বর লিখুন",
        isError: true,
      );
      return;
    }

    if (hospitalController.text.trim().isEmpty) {
      showAppSnackbar(
        title: "সতর্কতা",
        message: "হাসপাতালের নাম লিখুন",
        isError: true,
      );
      return;
    }

    if (locationController.text.trim().isEmpty) {
      showAppSnackbar(
        title: "সতর্কতা",
        message: "লোকেশন লিখুন",
        isError: true,
      );
      return;
    }

    if (unitsController.text.trim().isEmpty) {
      showAppSnackbar(
        title: "সতর্কতা",
        message: "কত ইউনিট রক্ত লাগবে লিখুন",
        isError: true,
      );
      return;
    }

    if (selectedBlood.value == null) {
      showAppSnackbar(
        title: "সতর্কতা",
        message: "রক্তের গ্রুপ নির্বাচন করুন",
        isError: true,
      );
      return;
    }

    /// ---------- API ----------

    try {
      isLoading.value = true;

      final hour = selectedTime.value.hour;
      final minute = selectedTime.value.minute;
      final formattedTime =
          "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:00";

      final updateData = {
        "name": nameController.text.trim(),
        "phone": phoneController.text.trim(),
        "hospital": hospitalController.text.trim(),
        "location": locationController.text.trim(),
        "unit": unitsController.text.trim(),
        "reason": reasonController.text.trim(),
        "description": descriptionController.text.trim(),
        "blood_group": selectedBlood.value,
        "status": selectedType.value,
        "date": selectedDate.value.toString().split(" ")[0],
        "time": formattedTime,
      };

      final response = await services.bloodUpdate(
        post!.id.toString(),
        updateData,
      );

      final result = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {

        Get.back();
        myBloodPostController.getBloodPost();

        showAppSnackbar(
          title: "সফল",
          message: "আপডেট করা হয়েছে",
        );

      } else {

        showAppSnackbar(
          title: "Error",
          message: result['result'],
          isError: true,
        );

      }
    } catch (e) {

      showAppSnackbar(
        title: "Error",
        message: "Something went wrong : $e",
        isError: true,
      );

    } finally {
      isLoading.value = false;
    }
  }

  void pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  void pickTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
    );

    if (picked != null) {
      selectedTime.value = picked;
    }
  }
}