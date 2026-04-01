import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/app_pages.dart';

class AuthSeassion {
  final String token = "auth_token";

  Future<void> saveToken(String tokenValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(token, tokenValue); //  key = auth_token, value = real token
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(token);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(token);
    Get.offAllNamed(Routes.WELCOME);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(token);
  }
}
