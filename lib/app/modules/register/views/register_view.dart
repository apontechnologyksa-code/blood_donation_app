import 'package:blood_donation_app/app/utils/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/common/custom_dropdown.dart';
import '../../../widgets/common/custom_elevated_button.dart';
import '../../../widgets/common/custom_text_field.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: Form(
              key: controller.formKey,
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
                              "অ্যাকাউন্ট তৈরি করুন",
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "ফর্মটি পূরণ করে রেজিস্ট্রেশন সম্পন্ন করুন",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: scheme.onSurface.withValues(alpha: .65),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        CustomTextField(
                          controller: controller.nameController,
                          hintText: "আপনার নাম",
                          labelText: "পূর্ণ নাম লিখুন",
                          icon: Iconsax.personalcard,
                          validator: controller.validateName,
                        ),
                        const SizedBox(height: 12),

                        CustomTextField(
                          controller: controller.phoneController,
                          hintText: "আপনার নাম্বার",
                          labelText: "হোয়াটস্যাপ নাম্বার লিখুন",
                          icon: Iconsax.call,
                          keyboardType: TextInputType.phone,
                          validator: controller.validatePhone,
                        ),
                        const SizedBox(height: 12),

                        Obx(
                          () => CustomDropdown<String>(
                            labelText: "রক্তের গ্রুপ",
                            hintText: "রক্তের গ্রুপ নির্বাচন করুন",
                            icon: Iconsax.health,
                            value: controller.selectedBlood.value,
                            items: controller.bloodGroups
                                .map(
                                  (e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) =>
                                controller.selectedBlood.value = v,
                            validator: controller.validateBlood,
                          ),
                        ),

                        const SizedBox(height: 10),

                        CustomTextField(
                          controller: controller.emailController,
                          hintText: "আপনার জিমেইল",
                          labelText: "জিমেইল একাউন্ট লিখুন",
                          icon: Iconsax.sms,
                          keyboardType: TextInputType.emailAddress,
                          validator: controller.validateEmail,
                        ),

                        const SizedBox(height: 12),

                        CustomTextField(
                          controller: controller.passwordController,
                          hintText: "আপনার পাসওয়ার্ড",
                          labelText: "আপনার পাসওয়ার্ড লিখুন",
                          icon: Iconsax.key,
                          isPassword: true,
                          keyboardType: TextInputType.text,

                          validator: controller.validatePassword,
                        ),
                        const SizedBox(height: 12),

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

                        Obx(
                          () => CustomElevatedButton(
                            text: "নিবন্ধন করুন",
                            color: scheme.primary,
                            textColor: Colors.white,
                            isLoading: controller.isLoading.value,
                            onPress: controller.register,
                          ),
                        ),

                        const SizedBox(height: 16),

                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "আগে থেকেই একাউন্ট আছে? ",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: scheme.onSurface.withValues(alpha: .7),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.LOGIN);
                                },
                                child: Text(
                                  "লগইন করুন",
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
      ),
    );
  }
}
