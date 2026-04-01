import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeThemesController extends GetxController {

  RxBool isDarkMode = Get.isDarkMode.obs;

  void toggleTheme(bool val) {
    isDarkMode.value = val;
    Get.changeThemeMode(val ? ThemeMode.dark : ThemeMode.light);
    saveTheme(val);
  }

  Future<void> saveTheme(bool val) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDarkMode", val);
  }
}