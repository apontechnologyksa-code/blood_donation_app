import 'package:blood_donation_app/app/utils/constants/app_colors.dart';
import 'package:blood_donation_app/app/utils/constants/app_images.dart';
import 'package:blood_donation_app/app/utils/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/common/custom_elevated_button.dart';
import '../../../widgets/common/custom_outline_button.dart';
import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 80),

                  Image.asset(AppImages.logo, height: 300, fit: BoxFit.cover),

                  const SizedBox(height: 50),

                  Text(
                    AppText.welcomeText1,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    AppText.welcomeText2,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),

              Column(
                children: [
                  CustomElevatedButton(
                    text: AppText.loginText,
                    color: AppColors.primary,
                    textColor: Colors.white,
                    onPress: () {
                      controller.goToLoginScreen();
                    },
                  ),

                  const SizedBox(height: 15),

                  CustomOutlineButton(
                    text: AppText.signUpText,
                    onPressed: () {
                      controller.goToRegisterScreen();
                    },
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}
