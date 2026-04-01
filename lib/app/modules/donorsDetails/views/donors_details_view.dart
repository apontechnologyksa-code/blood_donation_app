import 'package:blood_donation_app/app/data/helpers/bangla_datetime_formatter.dart';
import 'package:blood_donation_app/app/data/helpers/contact_helper.dart';
import 'package:blood_donation_app/app/data/model/donor.dart';
import 'package:blood_donation_app/app/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/app_config.dart';
import '../../../utils/constants/app_images.dart';
import '../controllers/donors_details_controller.dart';

class DonorsDetailsView extends GetView<DonorsDetailsController> {
  final Donors donors;

  const DonorsDetailsView({super.key, required this.donors});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    String name = donors.name ?? "";
    String phone = donors.phone ?? "";
    String email = donors.email ?? "";

    String profileImage =
        (donors.profileImage != null && donors.profileImage!.isNotEmpty)
        ? "${AppConfig.baseUrl}${donors.profileImage}"
        : "";

    String blood = donors.blood ?? "";

    String division = donors.division ?? "";
    String district = donors.district ?? "";
    String upazila = donors.upazila ?? "";
    String fullAddress = donors.fullAddress ?? "";
    String facebook = donors.facebookLink ?? "";

    String location = "";

    if (division.isNotEmpty) location += division;
    if (district.isNotEmpty)
      location += (location.isNotEmpty ? ", " : "") + district;
    if (upazila.isNotEmpty)
      location += (location.isNotEmpty ? ", " : "") + upazila;
    if (fullAddress.isNotEmpty)
      location += (location.isNotEmpty ? ", " : "") + fullAddress;

    if (location.isEmpty) location = "ঠিকানা  তথ্য এড করা হয়নি";

    String lastDonation;
    if (donors.lastDonationDate != null &&
        donors.lastDonationDate!.isNotEmpty) {
      lastDonation =
          "${BanglaDateTimeFormatter.formatBanglaDateTime(donors.lastDonationDate)}";
    } else {
      lastDonation = "রক্তদানের তথ্য এড করা হয়নি";
    }

    String details = donors.details ?? "সম্পূর্ণ বিবরণ তথ্য এড করা হয়নি";

    final controller = Get.put(DonorsDetailsController());

    return Scaffold(
      backgroundColor: cs.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: Text(
          'ব্লাড দাতা প্রোফাইল',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          Obx(() => IconButton(
            icon: Icon(
              controller.isFavorite(donors.id) ? Iconsax.heart5 : Iconsax.heart,
              color: controller.isFavorite(donors.id) ? Colors.black : Colors.white,
            ),
            onPressed: () {
              controller.toggleFavorite(donors);
            },
          )),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: cs.primary.withValues(alpha: 0.2),
                        width: 4,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: cs.surface,
                      backgroundImage:
                          (profileImage != null && profileImage.isNotEmpty)
                          ? NetworkImage(profileImage)
                          : null,
                      child: (profileImage == null || profileImage.isEmpty)
                          ? ClipOval(
                              child: Image.asset(
                                AppImages.avatarImage,
                                fit: BoxFit.cover,
                              ),
                            )
                          : null,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: cs.error,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      blood,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              name,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
                color: cs.onBackground,
              ),
            ),
            Text(
              "নিয়মিত দাতা",
              style: textTheme.bodyMedium?.copyWith(
                color: cs.onBackground.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCircularAction(
                  Iconsax.call,
                  "কল করুন",
                  Colors.green,
                  () {
                    ContactHelper.makeCall(phone);
                  },
                  cs,
                ),
                const SizedBox(width: 25),
                _buildCircularAction(
                  Iconsax.message_2,
                  "মেসেজ",
                  Colors.orange,
                  () {
                    ContactHelper.sendWhatsAppMessage(
                        phone,
                        "আসসালামু আলাইকুম, আপনার কি এখনো $blood রক্ত প্রয়োজন?"
                    );
                  },
                  cs,
                ),
                const SizedBox(width: 25),
                _buildCircularAction(
                  Icons.facebook,
                  "সোশ্যাল",
                  Colors.blueAccent,
                  () {
                    ContactHelper.openFacebook(facebook);
                  },
                  cs,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(35),
                ),
                boxShadow: [
                  BoxShadow(
                    color: cs.shadow.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "তথ্য",
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: cs.onSurface,
                    ),
                  ),
                  const SizedBox(height: 20),

                  _infoTile(Iconsax.location, "অবস্থান", location, cs),
                  _infoTile(
                    Iconsax.calendar_1,
                    "সর্বশেষ রক্তদান",
                    lastDonation,
                    cs,
                  ),
                  _infoTile(Iconsax.sms, "ইমেল", email, cs),
                  _infoTile(Iconsax.call, "ফোন নাম্বার", phone, cs),

                  const SizedBox(height: 10),
                  Divider(color: cs.onSurface.withValues(alpha: 0.1)),
                  const SizedBox(height: 10),
                  Text(
                    "সম্পূর্ণ বিবরণ",
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: cs.onSurface,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    details,
                    style: textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface.withValues(alpha: 0.7),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ContactHelper.openMap(location);
                      }
                      ,
                      icon: Icon(Iconsax.map_1, color: Colors.white),
                      label: Text(
                        "গুগল ম্যাপে দেখুন",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color:Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cs.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String title, String value, ColorScheme cs) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: cs.primary, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: cs.onSurface.withValues(alpha: 0.6),
                    fontSize: 12,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: cs.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularAction(
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
    ColorScheme cs,
  ) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: cs.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(icon, color: color, size: 24),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: cs.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
