import 'package:blood_donation_app/app/utils/constants/app_colors.dart';
import 'package:blood_donation_app/app/widgets/common/custom_elevated_button.dart';
import 'package:blood_donation_app/app/widgets/common/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("পাসওয়ার্ড পরিবর্তন করুন"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [

                CustomTextField(
                  controller: controller.oldController,
                  hintText: 'পুরাতন পাসওয়ার্ড লিখুন',
                  labelText: 'পুরাতন পাসওয়ার্ড',
                  icon: Icons.lock_open_outlined,
                  isPassword: true,
                ),
                const SizedBox(height: 15),

                CustomTextField(
                  controller: controller.newController,
                  hintText: 'নতুন পাসওয়ার্ড লিখুন',
                  labelText: 'নতুন পাসওয়ার্ড',
                  icon: Icons.lock_outline,
                  isPassword: true,
                ),
                const SizedBox(height: 15),

                CustomTextField(
                  controller: controller.confirmController,
                  hintText: 'নিশ্চিতকরণ পাসওয়ার্ড লিখুন',
                  labelText: 'নিশ্চিতকরণ পাসওয়ার্ড',
                  icon: Icons.lock_outline,
                  isPassword: true,
                ),
                const SizedBox(height: 25),

                Obx(
                      () => CustomElevatedButton(
                    text: "পাসওয়ার্ড পরিবর্তন করুন",
                    onPress: () {
                      controller.changePassword();
                    },
                    textColor: Colors.white,
                    color: AppColors.primary,
                    isLoading: controller.isLoading.value,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}