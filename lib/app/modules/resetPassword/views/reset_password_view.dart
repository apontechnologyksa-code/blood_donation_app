import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_images.dart';
import '../../../widgets/common/custom_elevated_button.dart';
import '../../../widgets/common/custom_text_field.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('পাসওয়ার্ড রিসেট করুন'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.19),
                  shape: BoxShape.circle,
                ),
                child: Center(child: Image.asset(AppImages.logo, width: 100)),
              ),
              const SizedBox(height: 24),
              Text(
                "পাসওয়ার্ড রিসেট করুন",
                style: theme.textTheme.titleLarge?.copyWith(),
              ),
              const SizedBox(height: 8),
              Text(
                "পাসওয়ার্ড রিসেটের জন্য আপনার নতুন পাসওয়ার্ড লিখুন",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurface.withValues(alpha: .65),
                ),
              ),
              const SizedBox(height: 30),

              CustomTextField(
                hintText: "নতুন পাসওয়ার্ড",
                labelText: "Password",
                isPassword: true,
                controller: controller.passwordController,
                icon: Iconsax.key,
              ),

              const SizedBox(height: 16),

              CustomTextField(
                hintText: "নতুন পাসওয়ার্ড আবার লিখুন",
                labelText: "Confirm Password",
                isPassword: true,
                controller: controller.passwordConfirmationController,
                icon: Iconsax.key,
              ),

              const SizedBox(height: 24),

              Obx(
                () => CustomElevatedButton(
                  text: "পাসওয়ার্ড রিসেট করুন",
                  color: AppColors.primary,
                  textColor: Colors.white,
                  isLoading: controller.isLoading.value,
                  onPress: () => controller.resetPassword(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
