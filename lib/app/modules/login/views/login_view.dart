import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/constants/app_images.dart';
import '../../../widgets/common/custom_elevated_button.dart';
import '../../../widgets/common/custom_text_field.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Get.toNamed(Routes.REGISTER);
          },
          icon: Icon(Iconsax.arrow_left_2, color: scheme.onSurface),
        ),
      ),
      extendBodyBehindAppBar: true,

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
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
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey.withValues(alpha: 0.19),
                              shape: BoxShape.circle,
                            ),
                            child: Center(child: Image.asset(AppImages.logo)),
                          ),

                          SizedBox(height: 12),

                          Text(
                            "লগইন করুন",
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "আপনার একাউন্টে প্রবেশ করুন",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: scheme.onSurface.withValues(alpha: .65),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      CustomTextField(
                        controller: controller.emailController,
                        hintText: "আপনার জিমেইল",
                        labelText: "জিমেইল একাউন্ট লিখুন",
                        icon: Iconsax.sms,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 12),

                      CustomTextField(
                        controller: controller.passwordController,
                        hintText: "আপনার পাসওয়ার্ড",
                        labelText: "আপনার পাসওয়ার্ড লিখুন",
                        icon: Iconsax.key,
                        keyboardType: TextInputType.text,
                        isPassword: true,
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? "আপনার পাসওয়ার্ড লিখুন"
                            : null,
                      ),
                      const SizedBox(height: 15),

                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.FORGOT_PASSWORD);
                          },
                          child: Text(
                            "পাসওয়ার্ড ভুলে গেছেন?",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Obx(
                        () => CustomElevatedButton(
                          text: "লগইন করুন",
                          color: scheme.primary,
                          textColor: Colors.white,
                          isLoading: controller.isLoading.value,
                          onPress: controller.login,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "একাউন্ট করা নাই? ",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: scheme.onSurface.withValues(alpha: .7),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.REGISTER);
                              },
                              child: Text(
                                "নিবন্ধন করুন",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: scheme.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
