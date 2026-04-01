import 'dart:convert';
import 'package:blood_donation_app/app/data/helpers/app_snackbar.dart';
import 'package:blood_donation_app/app/data/model/donor.dart';
import 'package:get/get.dart';
import '../../../data/services/DonorServices.dart';

class DonorsController extends GetxController {
  final donors = <Donors>[].obs;
  final isLoading = false.obs;

  final DonorServices donorServices = DonorServices();

  final searchDonors = <Donors>[].obs;
  final searchText = ''.obs;

  @override
  void onInit() {
    allDonors();
    super.onInit();
  }

  Future<void> allDonors() async {
    try {
      isLoading.value = true;

      final response = await donorServices.allDonors();

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final List list = data['donors'];

        donors.clear();
        for (int i = 0; i < list.length; i++) {
          donors.add(Donors.fromJson(list[i]));
        }

        applySearch(searchText.value);
      } else {
        showAppSnackbar(title: "", message: "Something went wrong");
      }
    } catch (e) {
      throw Exception("Something went wrong : $e");
    } finally {
      isLoading(false);
    }
  }

  void onSearchChange(String value) {
    searchText.value = value;
    applySearch(value);
  }

  void applySearch(String query) {
    final q = query.trim().toLowerCase();

    if (q.isEmpty) {
      searchDonors.assignAll(donors);
      return;
    }

    searchDonors.assignAll(
      donors.where((p) {
        final name = (p.name ?? "").toLowerCase();
        final blood = (p.blood ?? "").toLowerCase();
        final phone = (p.phone ?? "").toLowerCase();
        final lastDonationDate = (p.lastDonationDate ?? "").toLowerCase();
        return name.contains(q) ||
            blood.contains(q) ||
            phone.contains(q) ||
            lastDonationDate.contains(q);
      }).toList(),
    );
  }

  void clearSearch() {
    searchText.value = '';
    searchDonors.assignAll(donors);
  }
}
