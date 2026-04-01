import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/model/blood_request.dart';
import '../../../data/services/blood_services.dart';

class BloodRequestController extends GetxController {


   final BloodServices bloodServices = BloodServices();

  final RxBool isLoading = false.obs;
  final RxList<BloodRequestPost> bloodPosts = <BloodRequestPost>[].obs;


  @override
  void onInit() {
    super.onInit();
    getAllBloodRequestPosts();
  }

Future<void> getAllBloodRequestPosts() async {

  try {

    isLoading.value = true;

    final response = await bloodServices.allBloodRequest();
    final result = jsonDecode(response.body);

    if (response.statusCode == 200) {

      List data = result['data'];

      bloodPosts.clear();

      for (var item in data) {
        bloodPosts.add(BloodRequestPost.fromJson(item));
      }

    } else {
      Get.snackbar(
        "Something went wrong",
        "Something went wrong",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

  } catch (e) {
    throw Exception(e.toString());
  } finally {
    isLoading.value = false;
  }
}






}
