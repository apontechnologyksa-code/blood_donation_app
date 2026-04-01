import 'dart:math';

import 'package:blood_donation_app/app/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/app_config.dart';
import '../../../utils/constants/app_images.dart';
import '../../../widgets/common/custom_data_field.dart';
import '../../../widgets/common/custom_dropdown.dart';
import '../../../widgets/common/custom_elevated_button.dart';
import '../../../widgets/common/custom_text_field.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'প্রোফাইল তথ্য আপডেট',
          style: TextStyle(fontFamily: "Kohinoor",color: Colors.white),
        ),
        backgroundColor: AppColors.primary,

        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.primary,
          statusBarIconBrightness: Brightness.light,
        ),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                    ),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  width: 110,
                                  height: 110,
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: theme.primaryColor.withValues(
                                        alpha: 0.2,
                                      ),
                                      width: 2,
                                    ),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.05,
                                        ),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: ClipOval(
                                    child: Obx(() {
                                      final file = controller.pickedImage.value;
                                      final path = controller.profileImage.value;

                                      if (file != null) {
                                        return Image.file(
                                          file,
                                          fit: BoxFit.cover,
                                          width: 120,
                                          height: 120,
                                        );
                                      }

                                      if (path != null && path.isNotEmpty) {
                                        final url = path.startsWith("http")
                                            ? path
                                            : "${AppConfig.baseUrl}$path";

                                        return Image.network(
                                          url,
                                          fit: BoxFit.cover,
                                          width: 120,
                                          height: 120,
                                          errorBuilder: (_, __, ___) => Image.asset(
                                            AppImages.avatarImage,
                                            fit: BoxFit.cover,
                                            width: 120,
                                            height: 120,
                                          ),
                                        );
                                      }

                                      return Image.asset(
                                        AppImages.avatarImage,
                                        fit: BoxFit.cover,
                                        width: 120,
                                        height: 120,
                                      );
                                    }),
                                  ),                                ),

                                InkWell(
                                  onTap: () {
                                    showPickSheet(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: theme.primaryColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),




                              ],
                            ),

                            const SizedBox(height: 16),

                            Text(
                              "ছবি নির্বাচন করুন",
                              style: theme.textTheme.titleLarge?.copyWith(),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        CustomTextField(
                          controller: controller.nameController,
                          hintText: "আপনার নাম",
                          labelText: "পূর্ণ নাম লিখুন",
                          icon: Iconsax.personalcard,
                        ),
                        const SizedBox(height: 15),

                        CustomTextField(
                          controller: controller.phoneController,
                          hintText: "আপনার নাম্বার",
                          labelText: "হোয়াটস্যাপ নাম্বার লিখুন",
                          icon: Iconsax.call,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 15),



                        CustomTextField(
                          controller: controller.fbController,
                          hintText: "ফেসবুক প্রোফাইল লিংক",
                          labelText: "প্রোফাইল লিংক লিখুন",
                          icon: Iconsax.link,
                          keyboardType: TextInputType.text,
                        ),

                        const SizedBox(height: 15),




                        Obx(() {
                          final items = controller.bloodGroups;
                          final v = controller.selectedBlood.value;
                          final safeValue = (v != null && items.contains(v)) ? v : null;

                          return CustomDropdown<String>(
                            labelText: "রক্তের গ্রুপ",
                            hintText: "রক্তের গ্রুপ নির্বাচন করুন",
                            icon: Iconsax.health,
                            value: safeValue,
                            items: items
                                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (v) => controller.selectedBlood.value = v,
                          );
                        }),

                        const SizedBox(height: 15),

                        Obx(() {
                          final items = controller.divisions;
                          final v = controller.selectedDivision.value;
                          final safeValue = (v != null && items.contains(v)) ? v : null;

                          return CustomDropdown<String>(
                            labelText: "বিভাগ",
                            hintText: "বিভাগ নির্বাচন করুন",
                            icon: Iconsax.location,
                            value: safeValue,
                            items: items
                                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                                .toList(),
                            onChanged: controller.onDivisionChanged,
                          );
                        }),

                        const SizedBox(height: 15),

                        Obx(() {
                          final items = controller.districts;
                          final v = controller.selectedDistrict.value;
                          final safeValue = (v != null && items.contains(v)) ? v : null;

                          return CustomDropdown<String>(
                            labelText: "জেলা",
                            hintText: "জেলা নির্বাচন করুন",
                            icon: Iconsax.location,
                            value: safeValue,
                            items: items
                                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                                .toList(),
                            onChanged: controller.onDistrictChanged,
                          );
                        }),

                        const SizedBox(height: 15),

                        Obx(() {
                          final items = controller.upazilas;
                          final v = controller.selectedUpazila.value;
                          final safeValue = (v != null && items.contains(v)) ? v : null;

                          return CustomDropdown<String>(
                            labelText: "উপজেলা",
                            hintText: "উপজেলা নির্বাচন করুন",
                            icon: Iconsax.location,
                            value: safeValue,
                            items: items
                                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                                .toList(),
                            onChanged: controller.onUpazilaChanged,
                          );
                        }),


                        const SizedBox(height: 15),


                        CustomTextField(
                          controller: controller.addressController,
                          hintText: "আপনার ঠিকানা",
                          labelText: "আপনার পূর্ণ ঠিকানা লিখুন",
                          icon: Iconsax.location4,
                          keyboardType: TextInputType.text,
                        ),

                        const SizedBox(height: 15),

                        CustomTextField(
                          controller: controller.detailsController,
                          hintText: "আপনার সম্পর্কে বিস্তারিত",
                          labelText: "আপনার সম্পর্কে বিস্তারিত লিখুন",
                          icon: Iconsax.document_text,
                          keyboardType: TextInputType.text,
                        ),

                        const SizedBox(height: 15),



                        Obx(() {
                          return CustomDateField(
                            labelText: "শেষ রক্তদানের তারিখ",
                            icon: Icons.calendar_month_rounded,
                            valueText: controller.lastDonationDateText,
                            onTap: () => controller.pickLastDonationDate(context),
                            errorText: controller.lastDonationDate.value == null ? "তারিখ নির্বাচন করুন" : null,
                          );
                        }),

                        const SizedBox(height: 15),


                        Obx(
                              () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                " আপনি কে?",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),

                              const SizedBox(height: 8),

                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () =>
                                      controller.selectedUserType.value =
                                      "user",
                                      child: Row(
                                        children: [
                                          Radio<String>(
                                            value: "user",
                                            groupValue: controller
                                                .selectedUserType
                                                .value,
                                            onChanged: (v) =>
                                            controller
                                                .selectedUserType
                                                .value =
                                            v!,
                                          ),
                                          const Text("ব্যবহারকারী"),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    child: InkWell(
                                      onTap: () =>
                                      controller.selectedUserType.value =
                                      "donor",
                                      child: Row(
                                        children: [
                                          Radio<String>(
                                            value: "donor",
                                            groupValue: controller
                                                .selectedUserType
                                                .value,
                                            onChanged: (v) =>
                                            controller
                                                .selectedUserType
                                                .value =
                                            v!,
                                          ),
                                          const Text("ব্লাড ডোনার"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 15),

                       Obx(() =>  CustomElevatedButton(
                         text: "আপডেট করুন",
                         color: scheme.primary,
                         textColor: Colors.white,
                         isLoading: controller.isLoading.value,
                         onPress: controller.updateProfile,
                       ),)


                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  void showPickSheet( BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        ),
        child: Wrap(
          runSpacing: 10,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("গ্যালারি"),
              onTap: () {
                Get.back();
                controller.pickGalery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("ক্যামেরা"),
              onTap: () {
                Get.back();
                controller.pickCamera();
              },
            ),


          ],
        ),
      ),
    );
  }

}
