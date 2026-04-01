import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/helpers/app_snackbar.dart';
import '../../../data/model/donor.dart';
import 'package:blood_donation_app/app/data/seassion/auth_seassion.dart';

class DonorsDetailsController extends GetxController {
  var favList = <Donors>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> toggleFavorite(Donors donor) async {
    final AuthSeassion authSeassion = AuthSeassion();
    String? token = await authSeassion.getToken();

    if (token == null || token.isEmpty) {
      showAppSnackbar(
        title: "সতর্কতা",
        message: "প্রিয় তালিকায় যুক্ত করতে আগে লগইন করুন",
        isError: true,
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    if (isFavorite(donor.id)) {
      favList.removeWhere((element) => element.id == donor.id);

      showAppSnackbar(
        title: "সফল",
        message: "প্রিয় তালিকা থেকে সরানো হয়েছে",
      );
    } else {
      favList.add(donor);

      showAppSnackbar(
        title: "সফল",
        message: "প্রিয় তালিকায় যুক্ত হয়েছে",
      );
    }

    List<String> jsonList =
    favList.map((item) => jsonEncode(item.toJson())).toList();

    await prefs.setStringList('fav_donors', jsonList);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList('fav_donors');

    if (jsonList != null) {
      favList.value =
          jsonList.map((item) => Donors.fromJson(jsonDecode(item))).toList();
    }

    isLoading.value = false;
  }

  bool isFavorite(int? id) {
    return favList.any((element) => element.id == id);
  }

  Future<void> removeFromFavorite(int id) async {
    final prefs = await SharedPreferences.getInstance();

    favList.removeWhere((element) => element.id == id);

    List<String> jsonList =
    favList.map((item) => jsonEncode(item.toJson())).toList();

    await prefs.setStringList('fav_donors', jsonList);

    showAppSnackbar(
      title: "সফল",
      message: "প্রিয় তালিকা থেকে সরানো হয়েছে",
    );
  }
}