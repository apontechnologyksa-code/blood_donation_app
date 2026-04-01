import 'dart:convert';
import 'package:blood_donation_app/app/data/model/donor.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/helpers/app_snackbar.dart';

class FavDonorsController extends GetxController {
  var favList = <Donors>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    try {
      isLoading(true);
      final prefs = await SharedPreferences.getInstance();
      List<String>? jsonList = prefs.getStringList('fav_donors');

      if (jsonList != null) {
        favList.assignAll(
          jsonList.map((item) => Donors.fromJson(jsonDecode(item))).toList(),
        );
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> removeFromFavorite(int id) async {
    final prefs = await SharedPreferences.getInstance();

    favList.removeWhere((element) => element.id == id);

    List<String> jsonList =
    favList.map((item) => jsonEncode(item.toJson())).toList();

    await prefs.setStringList('fav_donors', jsonList);

    showAppSnackbar(
      title: "সফল",
      message: "প্রিয় তালিকা থেকে সরানো হয়েছে",
    );
  }
}