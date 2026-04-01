import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_images.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Spacer(),

            Column(
              children: [

                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  height: 250,
                  width: 250,
                  child: Image.asset(AppImages.logo, fit: BoxFit.cover),
                ),


              ],
            ),

            Spacer(),

            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: AppColors.primary,
                size: 42,
              ),
            ),


          ],
        ),
      ),
    );
  }
}

