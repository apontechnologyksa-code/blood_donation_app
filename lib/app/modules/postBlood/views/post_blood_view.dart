import 'package:blood_donation_app/app/utils/constants/app_colors.dart';
import 'package:blood_donation_app/app/widgets/common/custom_elevated_button.dart';
import 'package:blood_donation_app/app/widgets/common/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../widgets/common/custom_dropdown.dart';
import '../controllers/post_blood_controller.dart';

class PostBloodView extends GetView<PostBloodController> {
  const PostBloodView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primary,
        title: const Text(
          'রক্তের জন্য পোস্ট',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: controller.nameController,
                    hintText: 'আপনার নাম',
                    labelText: 'আপনার নাম',
                    icon: Icons.account_circle_rounded,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'আপনার নাম লিখুন';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),

                  CustomTextField(
                    controller: controller.phoneController,
                    hintText: 'ফোন নাম্বার',
                    labelText: 'ফোন নাম্বার',
                    icon: Icons.call,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ফোন নাম্বার লিখুন';
                      } else if (value.length < 11) {
                        return 'সঠিক ফোন নাম্বার দিন';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),

                  CustomTextField(
                    controller: controller.hospitalController,
                    hintText: 'রোগী কোন হসপিটালে',
                    labelText: 'রোগী কোন হসপিটালে',
                    icon: Icons.local_hospital_outlined,
                    validator: (value) =>
                        value!.isEmpty ? 'হসপিটালের নাম লিখুন' : null,
                  ),
                  const SizedBox(height: 15),

                  CustomTextField(
                    controller: controller.locationController,
                    hintText: 'হসপিটালের ঠিকানা',
                    labelText: 'হসপিটালের ঠিকানা',
                    icon: Icons.location_on_rounded,
                    validator: (value) =>
                        value!.isEmpty ? 'হসপিটালের ঠিকানা লিখুন' : null,
                  ),
                  const SizedBox(height: 15),

                  CustomTextField(
                    controller: controller.unitsController,
                    hintText: 'রক্তের পরিমান (ব্যাগ)',
                    labelText: 'রক্তের পরিমান (ব্যাগ)',
                    icon: Icons.shopping_bag_sharp,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value!.isEmpty ? 'ব্যাগের সংখ্যা লিখুন' : null,
                  ),
                  const SizedBox(height: 15),

                  CustomTextField(
                    controller: controller.reasonController,
                    hintText: 'কি কারণে রক্ত দরকার',
                    labelText: 'কি কারণে রক্ত দরকার',
                    icon: Icons.bloodtype,
                    validator: (value) =>
                        value!.isEmpty ? 'রক্তের কারণ লিখুন' : null,
                  ),
                  const SizedBox(height: 15),

                  CustomTextField(
                    controller: controller.descriptionController,
                    hintText: 'রোগীর সমস্যা',
                    labelText: 'রোগীর সমস্যা',
                    icon: Icons.report_problem_outlined,
                    validator: (value) =>
                        value!.isEmpty ? 'সমস্যার কথা লিখুন' : null,
                  ),
                  const SizedBox(height: 15),

                  Obx(
                    () => CustomDropdown<String>(
                      labelText: "রক্তের গ্রুপ",
                      hintText: "রক্তের গ্রুপ নির্বাচন করুন",
                      icon: Icons.health_and_safety_rounded,
                      // এখানে পরিবর্তন: সরাসরি ভ্যালু ব্যবহার করুন
                      value: controller.selectedBlood.value,
                      items: controller.bloodGroups
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => controller.selectedBlood.value = v,
                    ),
                  ),
                  const SizedBox(height: 15),

                  Obx(
                    () => TextFormField(
                      onTap: () => controller.pickDate(context),
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "কত তারিখ রক্ত লাগবে",
                        hintText: "তারিখ নির্বাচন করুন",
                        prefixIcon: const Icon(Icons.date_range),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      controller: TextEditingController(
                        text: controller.selectedDate.value == null
                            ? ""
                            : "${controller.selectedDate.value!.toLocal()}"
                                  .split(' ')[0],
                      ),
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'তারিখ নির্বাচন করুন'
                          : null,
                    ),
                  ),
                  const SizedBox(height: 15),

                  Obx(
                    () => TextFormField(
                      onTap: () => controller.pickTime(context),
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "কোন সময় রক্ত লাগবে",
                        hintText: "সময় নির্বাচন করুন",
                        prefixIcon: const Icon(Icons.access_time),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      controller: TextEditingController(
                        text: controller.selectedTime.value == null
                            ? ""
                            : controller.selectedTime.value!.format(context),
                      ),
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'সময় নির্বাচন করুন'
                          : null,
                    ),
                  ),
                  const SizedBox(height: 15),

                  Obx(
                    () => CustomDropdown<String>(
                      labelText: "অবস্থা",
                      hintText: "জরুরি কি না?",
                      icon: Iconsax.status4,
                      value: controller.selectedType.value,
                      items: controller.typeGroups
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => controller.selectedType.value = v,
                    ),
                  ),
                  const SizedBox(height: 25),

                  Obx(
                    () => CustomElevatedButton(
                      text: "পোস্ট করুন",
                      isLoading: controller.isLoading.value,
                      onPress: () {
                        controller.bloodPost();
                      },
                      color: AppColors.primary,
                      textColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
