import 'package:blood_donation_app/app/routes/app_pages.dart';
import 'package:blood_donation_app/app/utils/constants/app_colors.dart';
import 'package:blood_donation_app/app/utils/constants/app_config.dart';
import 'package:blood_donation_app/app/utils/constants/app_images.dart';
import 'package:blood_donation_app/app/widgets/common/custom_elevated_button.dart';
import 'package:blood_donation_app/app/widgets/profile/chip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../data/helpers/contact_helper.dart';
import '../../../widgets/profile/section.dart';
import '../../../widgets/profile/tile.dart';
import '../../donors/views/donors_view.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: CustomAppBar(text: "আমার প্রোফাইল এন্ড সেটিংস"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: Icon(
                Iconsax.notification,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              onPressed: () {
                Get.toNamed(Routes.NOTICE);
              },
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.profile();
          },
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            final user = controller.userData.value;

            final name = user.name ?? "নাম নেই";
            final phone = user.phone ?? "ফোন নেই";
            final blood = user.blood ?? "N/A";

            final imagePath = user.profileImage;

            final profileImageUrl = (imagePath == null || imagePath.isEmpty)
                ? null
                : "${AppConfig.baseUrl}$imagePath";

            final userType = user.userType ?? "user";
            final userTypeBn = userType == "donor"
                ? "ব্লাড ডোনার"
                : "ব্যবহারকারী";

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: .08),
                            blurRadius: 22,
                            offset: const Offset(0, 10),
                          ),
                        ],
                        border: Border.all(
                          color: theme.dividerColor.withValues(alpha: .12),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  theme.colorScheme.primary.withValues(
                                    alpha: .9,
                                  ),
                                  theme.colorScheme.secondary.withValues(
                                    alpha: .85,
                                  ),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colorScheme.primary.withValues(
                                    alpha: .25,
                                  ),
                                  blurRadius: 18,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Center(
                              child: ClipOval(
                                child: profileImageUrl == null
                                    ? Image.asset(
                                        AppImages.avatarImage,
                                        width: 64,
                                        height: 64,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        profileImageUrl,
                                        fit: BoxFit.cover,
                                        height: 64,
                                        width: 64,
                                        errorBuilder: (c, e, s) => Image.asset(
                                          AppImages.avatarImage,
                                          width: 64,
                                          height: 64,
                                          fit: BoxFit.cover,
                                        ),
                                        loadingBuilder: (c, child, loading) {
                                          if (loading == null) return child;
                                          return const Center(
                                            child: CupertinoActivityIndicator(),
                                          );
                                        },
                                      ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  phone,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.textTheme.bodySmall?.color
                                        ?.withValues(alpha: .75),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    ChipItem(
                                      icon: Icons.bloodtype_rounded,
                                      text: blood,
                                      theme: theme,
                                    ),
                                    ChipItem(
                                      icon: Icons.verified_user_rounded,
                                      text: userTypeBn,
                                      theme: theme,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            onPressed: () {
                              Get.toNamed(
                                Routes.EDIT_PROFILE,
                                arguments: controller.userData.value,
                              );
                            },
                            icon: Icon(
                              Icons.edit_rounded,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 18),
                      child: Column(
                        children: [
                          SectionCard(
                            title: "অ্যাকাউন্ট",
                            children: [
                              Tile(
                                icon: Icons.person_outline_rounded,
                                title: "ব্যক্তিগত তথ্য",
                                subtitle: "নাম, ফোন নম্বর, ঠিকানা",
                                onTap: () {
                                  Get.toNamed(Routes.PROFILE_DETAILS);
                                },
                              ),

                              _Divider(theme),

                              Tile(
                                icon: Icons.bloodtype_outlined,
                                title: "আমার রক্তের অনুরোধ",
                                subtitle: "আপনার করা সকল অনুরোধ",
                                onTap: () {
                                  Get.toNamed(Routes.MY_BLOOD_POST);
                                },
                              ),

                              _Divider(theme),

                              Tile(
                                icon: Icons.favorite_border_rounded,
                                title: "পছন্দের তালিকা",
                                subtitle: "আপনার সংরক্ষিত পোস্টসমূহ",
                                onTap: () {
                                  Get.toNamed(Routes.FAV_DONORS);

                                },
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          SectionCard(
                            title: "সেটিংস",
                            children: [
                              Tile(
                                icon: Icons.dark_mode_outlined,
                                title: "থিম",
                                subtitle: "লাইট / ডার্ক মোড",
                                onTap: () {
                                  Get.toNamed(Routes.CHANGE_THEMES);
                                },
                              ),
                              _Divider(theme),

                              Tile(
                                icon: Icons.lock_outline_rounded,
                                title: "পাসওয়ার্ড পরিবর্তন",
                                subtitle: "আপনার পাসওয়ার্ড আপডেট করুন",
                                onTap: () {

                                  Get.toNamed(Routes.CHANGE_PASSWORD);

                                },
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          SectionCard(
                            title: "সাপোর্ট",
                            children: [
                              Tile(
                                icon: Icons.help_outline_rounded,
                                title: "সহায়তা",
                                subtitle: "প্রশ্নোত্তর ও সাহায্য",
                                onTap: () {
                                  Get.toNamed(Routes.HELP_QUESTION);
                                },
                              ),

                              _Divider(theme),

                              Tile(
                                icon: Icons.contact_support_outlined,
                                title: "যোগাযোগ করুন",
                                subtitle: "আমাদের সাথে যোগাযোগ করুন",
                                onTap: () {
                                  Get.toNamed(Routes.CONTACT);

                                },
                              ),

                              _Divider(theme),

                              Tile(
                                icon: Icons.policy_outlined,
                                title: "গোপনীয়তা নীতি",
                                subtitle: "Terms & Privacy Policy",
                                onTap: () {

                                  ContactHelper.openPrivacyPolicy();

                                },
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          SectionCard(
                            title: "অ্যাকাউন্ট অ্যাকশন",
                            children: [
                              Tile(
                                icon: Icons.logout_rounded,
                                title: "লগআউট",
                                subtitle: "আপনার অ্যাকাউন্ট থেকে বের হয়ে যান",
                                onTap: () {
                                  controller.logout();
                                },
                              ),

                              _Divider(theme),

                              Tile(
                                icon: Icons.delete_outline_rounded,
                                title: "অ্যাকাউন্ট মুছুন",
                                subtitle: "স্থায়ীভাবে অ্যাকাউন্ট মুছে ফেলুন",
                                onTap: () {


                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.warning_amber_rounded,
                                                color: Colors.redAccent,
                                                size: 50,
                                              ),
                                              SizedBox(height: 15),
                                              Text(
                                                "আপনি কি নিশ্চিত?",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "আপনি কি আপনার অ্যাকাউন্ট স্থায়ীভাবে মুছে ফেলতে চান?",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                              SizedBox(height: 25),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: OutlinedButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      style: OutlinedButton.styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        side: BorderSide(color: Colors.grey),
                                                      ),
                                                      child: Text("বাতিল"),
                                                    ),
                                                  ),
                                                  SizedBox(width: 15),
                                                  Expanded(
                                                    child: Obx(
                                                          () => CustomElevatedButton(
                                                        text: 'মুছুন',
                                                        onPress: () {
                                                          controller.deleteAccount();
                                                        },
                                                        isLoading: controller.isLoading.value,
                                                        color: AppColors.primary,
                                                        textColor: Colors.white,
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
                                },
                              ),





                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

Widget _Divider(ThemeData theme) => Divider(
  height: 18,
  thickness: 1,
  color: theme.dividerColor.withValues(alpha: .12),
);
