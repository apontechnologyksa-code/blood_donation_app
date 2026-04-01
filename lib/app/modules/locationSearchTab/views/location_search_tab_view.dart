import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../data/helpers/bangla_datetime_formatter.dart';
import '../../../utils/constants/app_config.dart';
import '../../../widgets/common/custom_dropdown.dart';
import '../../../widgets/common/custom_elevated_button.dart';
import '../../../widgets/donors/donors_card.dart';
import '../controllers/location_search_tab_controller.dart';
import '../../../utils/constants/app_colors.dart';

class LocationSearchTabView extends GetView<LocationSearchTabController> {
  const LocationSearchTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LocationSearchTabController());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [


          Row(
            children: [
              Expanded(
                child: Obx(() {
                  final bloodItems = controller.bloodGroups;
                  final selectedBlood = controller.selectedBlood.value;
                  final safeBlood = (selectedBlood != null && bloodItems.contains(selectedBlood)) ? selectedBlood : null;

                  return CustomDropdown<String>(
                    labelText: "রক্তের গ্রুপ",
                    hintText: "রক্তের গ্রুপ নির্বাচন করুন",
                    icon: Iconsax.health,
                    value: safeBlood,
                    items: bloodItems.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    onChanged: (v) => controller.selectedBlood.value = v,
                  );
                }),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Obx(() {
                  final divisionItems = controller.divisions;
                  final selectedDivision = controller.selectedDivision.value;
                  final safeDivision = (selectedDivision != null && divisionItems.contains(selectedDivision)) ? selectedDivision : null;

                  return CustomDropdown<String>(
                    labelText: "বিভাগ",
                    hintText: "বিভাগ নির্বাচন করুন",
                    icon: Iconsax.location,
                    value: safeDivision,
                    items: divisionItems.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    onChanged: controller.onDivisionChanged,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(
                child: Obx(() {
                  final districtItems = controller.districts;
                  final selectedDistrict = controller.selectedDistrict.value;
                  final safeDistrict = (selectedDistrict != null && districtItems.contains(selectedDistrict)) ? selectedDistrict : null;

                  return CustomDropdown<String>(
                    labelText: "জেলা",
                    hintText: "জেলা নির্বাচন করুন",
                    icon: Iconsax.location,
                    value: safeDistrict,
                    items: districtItems.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    onChanged: controller.onDistrictChanged,
                  );
                }),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Obx(() {
                  final upazilaItems = controller.upazilas;
                  final selectedUpazila = controller.selectedUpazila.value;
                  final safeUpazila = (selectedUpazila != null && upazilaItems.contains(selectedUpazila)) ? selectedUpazila : null;

                  return CustomDropdown<String>(
                    labelText: "উপজেলা",
                    hintText: "উপজেলা নির্বাচন করুন",
                    icon: Iconsax.location,
                    value: safeUpazila,
                    items: upazilaItems.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    onChanged: controller.onUpazilaChanged,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 15),

          Obx(() => CustomElevatedButton(
            text: "সার্চ করুন",
            color: AppColors.primary,
            textColor: Colors.white,
            isLoading: controller.isLoading.value,
            onPress: controller.searchLocation,
          )),

          const SizedBox(height: 20),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.donors.isEmpty) {
                return const Center(child: Text("কোনও ডোনার পাওয়া যায়নি"));
              } else {

                return ListView.separated(

                  itemCount: controller.donors.length,
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


                  }, separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 10,);
                },
                );


              }
            }),
          ),
        ],
      ),
    );
  }
}