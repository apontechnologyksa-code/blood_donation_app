import 'package:blood_donation_app/app/data/helpers/bangla_datetime_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/app_config.dart';
import '../../../widgets/donors/donors_card.dart';
import '../controllers/blood_group_search_tab_controller.dart';

class BloodGroupSearchTabView extends GetView<BloodGroupSearchTabController> {
  const BloodGroupSearchTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BloodGroupSearchTabController());
    final theme = Theme.of(context);

    final List<String> bloodGroups = [
      "এ+",
      "এ-",
      "বি+",
      "বি-",
      "ও+",
      "ও-",
      "এবি+",
      "এবি-",
    ];

    final Color primaryColor = theme.colorScheme.primary;
    final Color secondaryColor = theme.colorScheme.secondary;
    final Color surfaceColor = theme.colorScheme.surface;
    final Color onSurfaceColor = theme.colorScheme.onSurface;
    final Color cardShadowColor = theme.shadowColor;


    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "রক্তের গ্রুপ নির্বাচন করুন",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        SizedBox(
          height: 240,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: bloodGroups.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final group = bloodGroups[index];

                return Obx(() {
                  final isSelected = controller.selectedGroup.value == group;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: isSelected
                              ? primaryColor.withValues(alpha: 0.3)
                              : cardShadowColor.withValues(alpha: 0.05),
                          blurRadius: isSelected ? 10 : 5,
                          offset: Offset(0, isSelected ? 5 : 2),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => controller.changeGroup(group),
                        borderRadius: BorderRadius.circular(20),
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: isSelected
                                  ? [primaryColor, secondaryColor]
                                  : [
                                      surfaceColor,
                                      surfaceColor.withValues(alpha: 0.95),
                                    ],
                            ),
                          ),
                          child: Stack(
                            clipBehavior: Clip.antiAlias,
                            children: [
                              Positioned(
                                bottom: -5,
                                right: -5,
                                child: Icon(
                                  Icons.water_drop,
                                  size: 40,
                                  color: isSelected
                                      ? Colors.white.withValues(alpha: 0.2)
                                      : primaryColor.withValues(alpha: 0.05),
                                ),
                              ),
                              Center(
                                child: Text(
                                  group,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.white
                                        : primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
              },
            ),
          ),
        ),


        const Divider(thickness: 1, indent: 20, endIndent: 20),

        Expanded(
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            }

            if (controller.donors.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_search,
                    size: 80,
                    color: onSurfaceColor.withValues(alpha: 0.2),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "কোন দাতা পাওয়া যায়নি",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: onSurfaceColor.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: controller.donors.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final theme = Theme.of(context);
                final cs = theme.colorScheme;

                final data = controller.donors[index];

                String safeText(String? v, {String fallback = ""}) {
                  final s = (v ?? "").trim();
                  if (s.isEmpty || s.toLowerCase() == "null") return fallback;
                  return s;
                }

                final String blood = safeText(data.blood);
                final String name = safeText(data.name, fallback: "নাম নেই");
                final String phone = safeText(data.phone, fallback: "নেই");
                final String lastDonateRaw = safeText(
                  BanglaDateTimeFormatter.formatBanglaDateTime(
                    data.lastDonationDate,
                  ),
                );
                final String lastDonate = lastDonateRaw.isNotEmpty
                    ? "শেষ রক্তদান: $lastDonateRaw"
                    : "রক্তদানের তথ্য এড করে নাই";

                final String imgPath = safeText(data.profileImage);
                final String profileUrl = imgPath.isEmpty
                    ? ""
                    : "${AppConfig.baseUrl}$imgPath";



                return DonorsCard(
                  data: data,
                  theme: theme,
                  cs: cs,
                  profileUrl: profileUrl,
                  name: name,
                  phone: phone,
                  lastDonate: lastDonate,
                  blood: blood,
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
