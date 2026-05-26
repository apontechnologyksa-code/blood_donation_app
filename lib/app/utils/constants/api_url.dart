import 'package:blood_donation_app/app/utils/constants/app_config.dart';

class ApiUrl {


  static final String register = "${AppConfig.baseUrl}/api/register";
  static final String login = "${AppConfig.baseUrl}/api/login";
  static final String profile = "${AppConfig.baseUrl}/api/profile";
  static final String update = "${AppConfig.baseUrl}/api/profile-update";
  static final String delete = "${AppConfig.baseUrl}/api/user/delete";



  static final String changePassword = "${AppConfig.baseUrl}/api/change-password";


  static final String forgotPassword = "${AppConfig.baseUrl}/api/forgot-password";
  static final String verifyOtp = "${AppConfig.baseUrl}/api/verify-otp";
  static final String resetPassword = "${AppConfig.baseUrl}/api/reset-password";









  static final String donor = "${AppConfig.baseUrl}/api/donors";
  static final String donorsByBlood = "${AppConfig.baseUrl}/api/donors/";




  static final String blood = "${AppConfig.baseUrl}/api/";


  static final String allBlood = "${blood}all-blood";
  static final String bloodStatus = "${blood}status/";


  static final String bloodPost = "${blood}blood-post";
  static final String myBlood = "${blood}blood";
  static final String bloodUpdate = "${blood}blood-update/";
  static final String bloodDelete = "${blood}blood-delete/";

}