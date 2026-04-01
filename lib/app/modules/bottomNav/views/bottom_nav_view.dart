import 'package:blood_donation_app/app/modules/donors/views/donors_view.dart';
import 'package:blood_donation_app/app/modules/home/views/home_view.dart';
import 'package:blood_donation_app/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../bloodRequest/views/blood_request_view.dart';
import '../controllers/bottom_nav_controller.dart';

class BottomNavView extends GetView<BottomNavController> {
  const BottomNavView({super.key});

  final List<Widget> pages = const [
    HomeView(),
    BloodRequestView(),
   DonorsView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(() {
      return PopScope(
        canPop: false,
        onPopInvoked: (didPop) => onBackPressed(context),
        child: Scaffold(
          body: pages[controller.currentIndex.value],

          bottomNavigationBar: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BottomNavigationBar(
                currentIndex: controller.currentIndex.value,
                onTap: controller.changeIndex,
                backgroundColor: Colors.transparent,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: theme.colorScheme.primary,
                unselectedItemColor: theme.colorScheme.onSurface.withValues(
                  alpha: .5,
                ),
                selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.home_2),
                    activeIcon: Icon(Iconsax.home_2),
                    label: "হোম",
                  ),

                  BottomNavigationBarItem(
                    icon: Icon(Icons.water_drop_outlined),
                    activeIcon: Icon(Icons.water_drop_outlined),
                    label: "অনুরোধ",
                  ),

                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.profile_2user),
                    activeIcon: Icon(Iconsax.profile_2user5),
                    label: "ডোনার",
                  ),

                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.user),
                    activeIcon: Icon(Iconsax.user),
                    label: "প্রোফাইল",
                  ),
                ],
              ),
            ),
          ),




        ),
      );
    });


  }

  Future<bool> onBackPressed(BuildContext context) async {
    if (controller.currentIndex.value != 0) {
      controller.currentIndex.value = 0;
      return false;
    }

    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final bool? exit = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 18),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: cs.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: theme.brightness == Brightness.dark ? .45 : .18),
                  blurRadius: 26,
                  offset: const Offset(0, 12),
                ),
              ],
              border: Border.all(
                color: cs.outlineVariant.withValues(alpha: .6),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 54,
                  width: 54,
                  decoration: BoxDecoration(
                    color: cs.primary.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Iconsax.logout,
                    color: cs.primary,
                    size: 26,
                  ),
                ),
                const SizedBox(height: 14),

                Text(
                  "অ্যাপ থেকে বের হতে চান?",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: cs.onSurface,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),

                Text(
                  "আপনি কি নিশ্চিত যে অ্যাপটি বন্ধ করতে চান?",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 18),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(color: cs.outline),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          foregroundColor: cs.onSurface,
                        ),
                        onPressed: () => Navigator.pop(context, false),
                        child: Text(
                          "বাতিল",
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: cs.error,
                          foregroundColor: cs.onError,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context, true),
                        child: Text(
                          "বের হোন",
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    if (exit == true) {
      SystemNavigator.pop();
    }

    return false;
  }
}
