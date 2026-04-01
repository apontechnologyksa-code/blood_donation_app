import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../data/model/donor.dart';
import '../../donorsDetails/views/donors_details_view.dart';
import '../controllers/fav_donors_controller.dart';
import '../../../utils/constants/app_colors.dart';

class FavDonorsView extends GetView<FavDonorsController> {
  const FavDonorsView({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final controller = Get.put(FavDonorsController());

    return Scaffold(
      backgroundColor: cs.background,
      appBar: AppBar(
        title: const Text(
          'প্রিয় ডোনার তালিকা',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.favList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.heart_slash,
                  size: 80,
                  color: cs.primary.withValues(alpha: 0.3),
                ),
                const SizedBox(height: 10),
                const Text(
                  "আপনার প্রিয় তালিকায় কেউ নেই",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: controller.favList.length,
          itemBuilder: (context, index) {
            final donor = controller.favList[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  child: Text(
                    donor.blood ?? "?",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
                title: Text(
                  donor.name ?? "Unknown",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(donor.phone ?? ""),
                trailing: IconButton(
                  icon: const Icon(Iconsax.trash, color: Colors.red),
                  onPressed: () {
                    showDeleteConfirmation(context, donor);
                  },
                ),
                onTap: () {
                  Get.to(() => DonorsDetailsView(donors: donor));
                },
              ),
            );
          },
        );
      }),
    );
  }

  void showDeleteConfirmation(BuildContext context, Donors donor) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Iconsax.trash, color: Colors.red, size: 30),
              ),
              const SizedBox(height: 20),

              const Text(
                "তালিকা থেকে সরান",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              Text(
                "আপনি কি নিশ্চিত যে আপনি '${donor.name}' কে আপনার প্রিয় তালিকা থেকে সরাতে চান?",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
              const SizedBox(height: 25),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text("না"),
                    ),
                  ),
                  const SizedBox(width: 15),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.removeFromFavorite(donor.id!);
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        "হ্যাঁ, সরান",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      transitionCurve: Curves.easeInOutBack,
    );
  }
}
