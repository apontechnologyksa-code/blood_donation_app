import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/common/custom_elevated_button.dart';
import '../../../widgets/common/custom_text_field.dart';
import '../controllers/forgot_password_controller.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_images.dart';
import 'package:iconsax/iconsax.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('পাসওয়ার্ড ভুলে গেছেন'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                "পাসওয়ার্ড ভুলে গেছেন?",
                style: theme.textTheme.titleLarge?.copyWith(),
              ),
              const SizedBox(height: 8),
              Text(
                "আপনার ইমেইলটি দিন। আমরা আপনাকে পাসওয়ার্ড রিসেট করার জন্য একটি ওটিপি পাঠাবো।",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurface.withValues(alpha: .65),
                ),
              ),
              const SizedBox(height: 30),

              CustomTextField(
                hintText: "আপনার জিমেইল",
                labelText: "জিমেইল একাউন্ট লিখুন",
                icon: Iconsax.sms,
                keyboardType: TextInputType.emailAddress,
                controller: controller.emailController,
              ),
              const SizedBox(height: 20),

              Obx(
                () => CustomElevatedButton(
                  text: "ওটিপি পাঠান",
                  textColor: Colors.white,
                  color: AppColors.primary,
                  isLoading: controller.isLoading.value,
                  onPress: () {
                    controller.sendOtp();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
