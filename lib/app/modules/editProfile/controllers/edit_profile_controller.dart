import 'dart:convert';
import 'dart:io';
import 'package:blood_donation_app/app/data/helpers/app_snackbar.dart';
import 'package:blood_donation_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/helpers/bd_location_data.dart';
import '../../../data/model/user.dart';
import '../../../data/services/AuthServices.dart';

class EditProfileController extends GetxController {



  final ProfileController controller = Get.put(ProfileController());





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
  final selectedBlood = RxnString();

  Rx<DateTime?> lastDonationDate = Rx<DateTime?>(null);

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final fbController = TextEditingController();
  final addressController = TextEditingController();
  final detailsController = TextEditingController();

  final selectedUserType = "user".obs;

  final selectedDivision = RxnString();
  final selectedDistrict = RxnString();
  final selectedUpazila = RxnString();

  final divisions = <String>[].obs;
  final districts = <String>[].obs;
  final upazilas = <String>[].obs;

  final pickedImage = Rxn<File>();
  final profileImage = RxnString();

  final ImagePicker imagePicker = ImagePicker();

  final isLoading = false.obs;

  final AuthServices authServices = AuthServices();

  @override
  void onInit() {
    super.onInit();

    divisions.assignAll(BdLocationData.divisions);

    loadUserData();
  }

  Future<void> updateProfile() async {

    if (nameController.text.trim().isEmpty) {
      showAppSnackbar(
        title: "সতর্কতা",
        message: "আপনার নাম লিখুন",
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

    if (selectedBlood.value!.isEmpty) {
      showAppSnackbar(
        title: "সতর্কতা",
        message: "রক্তের গ্রুপ নির্বাচন করুন",
        isError: true,
      );
      return;
    }

    if (selectedDivision.value!.isEmpty) {
      showAppSnackbar(
        title: "সতর্কতা",
        message: "বিভাগ নির্বাচন করুন",
        isError: true,
      );
      return;
    }

    if (selectedDistrict.value!.isEmpty) {
      showAppSnackbar(
        title: "সতর্কতা",
        message: "জেলা নির্বাচন করুন",
        isError: true,
      );
      return;
    }

    if (selectedUpazila.value!.isEmpty) {
      showAppSnackbar(
        title: "সতর্কতা",
        message: "উপজেলা নির্বাচন করুন",
        isError: true,
      );
      return;
    }

    if (addressController.text.trim().isEmpty) {
      showAppSnackbar(
        title: "সতর্কতা",
        message: "সম্পূর্ণ ঠিকানা লিখুন",
        isError: true,
      );
      return;
    }





    try {
      isLoading.value = true;

      final userData = {
        "name": nameController.text,
        "phone": phoneController.text,
        "facebook_link": fbController.text,
        "details": detailsController.text,
        "blood": selectedBlood.value,
        "division": selectedDivision.value,
        "district": selectedDistrict.value,
        "upazila": selectedUpazila.value,
        "full_address": addressController.text,
        "last_donation_date": lastDonationDateText,
        "user_type": selectedUserType.value,
      };

      final response = await authServices.updateProfile(
        userData,
        pickedImage.value,
      );

      final result = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back(result: true);
        showAppSnackbar(title: "সফল", message: "প্রোফাইল আপডেট করা হয়েছে");
        controller.profile();

      } else if (response.statusCode == 401) {
        showAppSnackbar(
          title: "কোনো সমস্যা হচ্ছে",
          message: result["message"],
          isError: true,
        );
      } else {
        print(response.body);
        showAppSnackbar(
          title: "কোনো সমস্যা হচ্ছে",
          isError: true,
          message: "Something went wrong : ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Something went wrong : $e");
    } finally {
      isLoading.value = false;
    }
  }

  void pickGalery() async {
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      this.pickedImage.value = File(pickedImage.path);
    } else {
      print("no image selected");
    }
  }

  void pickCamera() async {
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      this.pickedImage.value = File(pickedImage.path);
    } else {
      print("no image selected");
    }
  }

  void loadUserData() {
    final User user = Get.arguments;

    profileImage.value = user.profileImage;

    nameController.text = user.name ?? "";
    phoneController.text = user.phone ?? "";
    fbController.text = user.facebookLink ?? "";
    addressController.text = user.fullAddress ?? "";
    detailsController.text = user.details ?? "";

    lastDonationDate.value = user.lastDonationDate != null
        ? DateTime.tryParse(user.lastDonationDate!)
        : null;

    selectedBlood.value = user.blood;
    selectedUserType.value = user.userType ?? "user";

    selectedDivision.value = _existsIn(divisions, user.division)
        ? user.division
        : null;

    if (selectedDivision.value != null) {
      onDivisionChanged(selectedDivision.value, resetSelected: false);
    }

    selectedDistrict.value = _existsIn(districts, user.district)
        ? user.district
        : null;

    if (selectedDistrict.value != null) {
      onDistrictChanged(selectedDistrict.value, resetSelected: false);
    }

    selectedUpazila.value = _existsIn(upazilas, user.upazila)
        ? user.upazila
        : null;
  }

  bool _existsIn(List<String> list, String? value) {
    if (value == null || value.isEmpty) return false;
    return list.contains(value);
  }

  void onDivisionChanged(String? division, {bool resetSelected = true}) {
    selectedDivision.value = division;

    if (resetSelected) {
      selectedDistrict.value = null;
      selectedUpazila.value = null;
    }

    districts.clear();
    upazilas.clear();

    if (division == null || division.isEmpty) return;

    final dList =
        BdLocationData.divisionToDistricts[division] ?? const <String>[];

    districts.assignAll(dList.toSet().toList());
  }

  void onDistrictChanged(String? district, {bool resetSelected = true}) {
    selectedDistrict.value = district;

    if (resetSelected) {
      selectedUpazila.value = null;
    }

    upazilas.clear();

    final div = selectedDivision.value;
    if (div == null || div.isEmpty) return;
    if (district == null || district.isEmpty) return;

    final uList =
        BdLocationData.divisionDistrictUpazila[div]?[district] ??
        const <String>[];

    upazilas.assignAll(uList.toSet().toList());
  }

  void onUpazilaChanged(String? upazila) {
    selectedUpazila.value = upazila;
  }






  Future<void> pickLastDonationDate(context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: lastDonationDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      lastDonationDate.value = picked;
    }
  }

  String get lastDonationDateText {
    final dt = lastDonationDate.value;
    if (dt == null) return "";
    return "${dt.day.toString().padLeft(2, '0')}-"
        "${dt.month.toString().padLeft(2, '0')}-"
        "${dt.year}";
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    fbController.dispose();
    addressController.dispose();
    detailsController.dispose();
    super.onClose();
  }
}
