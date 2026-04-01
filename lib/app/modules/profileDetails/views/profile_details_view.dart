import 'package:blood_donation_app/app/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/profile_details_controller.dart';

class ProfileDetailsView extends GetView<ProfileDetailsController> {
  const ProfileDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.primary,
        title: const Text('প্রোফাইল বিস্তারিত', style: TextStyle(fontFamily: "Kohinoor",color: Colors.white)),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.primary,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
        ),
        child: Obx(() {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () => controller.profileC.profile(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: scheme.surface,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: theme.dividerColor.withValues(alpha: .12),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: .06),
                              blurRadius: 18,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            _Avatar(
                              theme: theme,
                              imagePath: controller.profileImageUrl,
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.name ?? "নাম নেই",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    controller.email ?? "ইমেইল নেই",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: scheme.onSurface.withValues(
                                        alpha: .70,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: [
                                      _Chip(
                                        theme: theme,
                                        icon: Icons.bloodtype_rounded,
                                        text: controller.blood ?? "N/A",
                                      ),
                                      _Chip(
                                        theme: theme,
                                        icon: Icons.verified_user_rounded,
                                        text: _userTypeBn(controller.userType),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 14),

                      _SectionCard(
                        theme: theme,
                        title: "ব্যক্তিগত তথ্য",
                        children: [
                          _InfoTile(
                            theme: theme,
                            icon: Icons.call_rounded,
                            title: "ফোন নম্বর",
                            value: controller.phone ?? "নেই",
                          ),
                          _Divider(theme),
                          _InfoTile(
                            theme: theme,
                            icon: Icons.location_on_rounded,
                            title: "ঠিকানা",
                            value: controller.fullAddress ??
                                _composeAddress(
                                  controller.upazila,
                                  controller.district,
                                  controller.division,
                                ),
                          ),
                          _Divider(theme),
                          _InfoTile(
                            theme: theme,
                            icon: Icons.facebook_rounded,
                            title: "ফেসবুক লিংক",
                            value: controller.facebookLink ?? "নেই",
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      _SectionCard(
                        theme: theme,
                        title: "ডোনেশন তথ্য",
                        children: [
                          _InfoTile(
                            theme: theme,
                            icon: Icons.calendar_month_rounded,
                            title: "সর্বশেষ রক্তদান",
                            value: controller.lastDonationDate ?? "নেই",
                          ),
                          _Divider(theme),
                          _InfoTile(
                            theme: theme,
                            icon: Icons.info_outline_rounded,
                            title: "বিস্তারিত",
                            value: controller.details ?? "নেই",
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      _SectionCard(
                        theme: theme,
                        title: "অ্যাকাউন্ট তথ্য",
                        children: [
                          _InfoTile(
                            theme: theme,
                            icon: Icons.badge_rounded,
                            title: "ইউজার আইডি",
                            value: (controller.id?.toString() ?? "N/A"),
                          ),
                          _Divider(theme),
                          _InfoTile(
                            theme: theme,
                            icon: Icons.schedule_rounded,
                            title: "অ্যাকাউন্ট তৈরি",
                            value: controller.createdAt ?? "N/A",
                          ),
                          _Divider(theme),
                          _InfoTile(
                            theme: theme,
                            icon: Icons.update_rounded,
                            title: "সর্বশেষ আপডেট",
                            value: controller.updatedAt ?? "N/A",
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}


class _SectionCard extends StatelessWidget {
  final ThemeData theme;
  final String title;
  final List<Widget> children;

  const _SectionCard({
    required this.theme,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.dividerColor.withValues(alpha: .12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 18,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final ThemeData theme;
  final IconData icon;
  final String title;
  final String value;

  const _InfoTile({
    required this.theme,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: .10),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: scheme.primary, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurface.withValues(alpha: .72),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final ThemeData theme;
  final IconData icon;
  final String text;

  const _Chip({
    required this.theme,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: .10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: scheme.primary.withValues(alpha: .18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: scheme.primary),
          const SizedBox(width: 6),
          Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: scheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final ThemeData theme;
  final String? imagePath;

  const _Avatar({required this.theme, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final scheme = theme.colorScheme;

    final url = (imagePath == null || imagePath!.isEmpty) ? null : imagePath;

    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            scheme.primary.withValues(alpha: .90),
            scheme.secondary.withValues(alpha: .85),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: .22),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipOval(
        child: url == null
            ? Icon(Icons.person_rounded, color: Colors.white.withValues(alpha: .9), size: 34)
            : Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (c, e, s) => Icon(
            Icons.person_rounded,
            color: Colors.white.withValues(alpha: .9),
            size: 34,
          ),
        ),
      ),
    );
  }
}

Widget _Divider(ThemeData theme) => Divider(
  height: 16,
  thickness: 1,
  color: theme.dividerColor.withValues(alpha: .12),
);

String _userTypeBn(String? type) {
  switch (type) {
    case "donor":
      return "ব্লাড ডোনার";
    case "user":
      return "ব্যবহারকারী";
    default:
      return "ব্যবহারকারী";
  }
}

String _composeAddress(String? upazila, String? district, String? division) {
  final parts = [upazila, district, division]
      .where((e) => e != null && e!.trim().isNotEmpty)
      .map((e) => e!.trim())
      .toList();

  return parts.isEmpty ? "নেই" : parts.join(", ");
}