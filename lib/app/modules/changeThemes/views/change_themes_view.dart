import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_donation_app/app/utils/constants/app_colors.dart';
import '../controllers/change_themes_controller.dart';

class ChangeThemesView extends GetView<ChangeThemesController> {
  const ChangeThemesView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('থিম সেটিংস'),
        elevation: 0,
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "আপনার পছন্দের থিমটি বেছে নিন",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 25),

            Obx(
              () => _buildThemeCard(
                context,
                title: "লাইট মোড",
                subtitle: "সাদা এবং উজ্জ্বল ইন্টারফেস",
                icon: Icons.light_mode_rounded,
                isSelected: !controller.isDarkMode.value,
                onTap: () => controller.toggleTheme(false),
              ),
            ),

            const SizedBox(height: 16),

            Obx(
              () => _buildThemeCard(
                context,
                title: "ডার্ক মোড",
                subtitle: "রাতের ব্যবহারের জন্য আরামদায়ক",
                icon: Icons.dark_mode_rounded,
                isSelected: controller.isDarkMode.value,
                onTap: () => controller.toggleTheme(true),
              ),
            ),

            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 20, color: AppColors.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "থিম পরিবর্তন করলে অ্যাপের কালার স্কিম তৎক্ষণাৎ আপডেট হবে।",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isDark ? Colors.grey[400] : Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final activeColor = AppColors.primary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected
                ? activeColor
                : (isDark ? Colors.white10 : Colors.black.withOpacity(0.05)),
            width: isSelected ? 2 : 1,
          ),
          color: isSelected
              ? activeColor.withOpacity(isDark ? 0.15 : 0.05)
              : theme.cardColor,
          boxShadow: [
            if (isSelected && !isDark)
              BoxShadow(
                color: activeColor.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? activeColor
                    : (isDark ? Colors.white10 : Colors.grey[200]),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? Colors.white
                    : (isDark ? Colors.grey[400] : Colors.grey[600]),
                size: 26,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? activeColor
                          : theme.textTheme.titleMedium?.color,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: activeColor, size: 28),
          ],
        ),
      ),
    );
  }
}
