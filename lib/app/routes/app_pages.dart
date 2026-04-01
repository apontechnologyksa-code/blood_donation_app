import 'package:get/get.dart';

import '../data/model/donor.dart';
import '../modules/bloodGroupSearchTab/bindings/blood_group_search_tab_binding.dart';
import '../modules/bloodGroupSearchTab/views/blood_group_search_tab_view.dart';
import '../modules/bloodRequest/bindings/blood_request_binding.dart';
import '../modules/bloodRequest/views/blood_request_view.dart';
import '../modules/bottomNav/bindings/bottom_nav_binding.dart';
import '../modules/bottomNav/views/bottom_nav_view.dart';
import '../modules/changePassword/bindings/change_password_binding.dart';
import '../modules/changePassword/views/change_password_view.dart';
import '../modules/changeThemes/bindings/change_themes_binding.dart';
import '../modules/changeThemes/views/change_themes_view.dart';
import '../modules/contact/bindings/contact_binding.dart';
import '../modules/contact/views/contact_view.dart';
import '../modules/donationTips/bindings/donation_tips_binding.dart';
import '../modules/donationTips/views/donation_tips_view.dart';
import '../modules/donors/bindings/donors_binding.dart';
import '../modules/donors/views/donors_view.dart';
import '../modules/donorsDetails/bindings/donors_details_binding.dart';
import '../modules/donorsDetails/views/donors_details_view.dart';
import '../modules/donorsSearch/bindings/donors_search_binding.dart';
import '../modules/donorsSearch/views/donors_search_view.dart' hide DonorsView;
import '../modules/editProfile/bindings/edit_profile_binding.dart';
import '../modules/editProfile/views/edit_profile_view.dart';
import '../modules/favDonors/bindings/fav_donors_binding.dart';
import '../modules/favDonors/views/fav_donors_view.dart';
import '../modules/forgotPassword/bindings/forgot_password_binding.dart';
import '../modules/forgotPassword/views/forgot_password_view.dart';
import '../modules/helpQuestion/bindings/help_question_binding.dart';
import '../modules/helpQuestion/views/help_question_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/locationSearchTab/bindings/location_search_tab_binding.dart';
import '../modules/locationSearchTab/views/location_search_tab_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/myBloodPost/bindings/my_blood_post_binding.dart';
import '../modules/myBloodPost/views/my_blood_post_view.dart';
import '../modules/notice/bindings/notice_binding.dart';
import '../modules/notice/views/notice_view.dart';
import '../modules/postBlood/bindings/post_blood_binding.dart';
import '../modules/postBlood/views/post_blood_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profileDetails/bindings/profile_details_binding.dart';
import '../modules/profileDetails/views/profile_details_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/resetPassword/bindings/reset_password_binding.dart';
import '../modules/resetPassword/views/reset_password_view.dart';
import '../modules/sastoTips/bindings/sasto_tips_binding.dart';
import '../modules/sastoTips/views/sasto_tips_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/successRequest/bindings/success_request_binding.dart';
import '../modules/successRequest/views/success_request_view.dart';
import '../modules/updateBloodPost/bindings/update_blood_post_binding.dart';
import '../modules/updateBloodPost/views/update_blood_post_view.dart';
import '../modules/verifyOtp/bindings/verify_otp_binding.dart';
import '../modules/verifyOtp/views/verify_otp_view.dart';
import '../modules/welcome/bindings/welcome_binding.dart';
import '../modules/welcome/views/welcome_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAV,
      page: () => const BottomNavView(),
      binding: BottomNavBinding(),
    ),
    GetPage(
      name: _Paths.DONORS,
      page: () => const DonorsView(),
      binding: DonorsBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_DETAILS,
      page: () => const ProfileDetailsView(),
      binding: ProfileDetailsBinding(),
    ),
    GetPage(
      name: _Paths.DONORS_DETAILS,
      page: () {
        final donors = Get.arguments as Donors;
        return DonorsDetailsView(donors: donors);
      },
      binding: DonorsDetailsBinding(),
    ),
    GetPage(
      name: _Paths.BLOOD_REQUEST,
      page: () => const BloodRequestView(),
      binding: BloodRequestBinding(),
    ),
    GetPage(
      name: _Paths.POST_BLOOD,
      page: () => const PostBloodView(),
      binding: PostBloodBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_BLOOD_POST,
      page: () => const UpdateBloodPostView(),
      binding: UpdateBloodPostBinding(),
    ),
    GetPage(
      name: _Paths.MY_BLOOD_POST,
      page: () => const MyBloodPostView(),
      binding: MyBloodPostBinding(),
    ),
    GetPage(
      name: _Paths.DONATION_TIPS,
      page: () => const DonationTipsView(),
      binding: DonationTipsBinding(),
    ),
    GetPage(
      name: _Paths.SASTO_TIPS,
      page: () => const SastoTipsView(),
      binding: SastoTipsBinding(),
    ),
    GetPage(
      name: _Paths.SUCCESS_REQUEST,
      page: () => const SuccessRequestView(),
      binding: SuccessRequestBinding(),
    ),
    GetPage(
      name: _Paths.DONORS_SEARCH,
      page: () => const DonorsSearchView(),
      binding: DonorsSearchBinding(),
    ),
    GetPage(
      name: _Paths.NOTICE,
      page: () => const NoticeView(),
      binding: NoticeBinding(),
    ),
    GetPage(
      name: _Paths.FAV_DONORS,
      page: () => const FavDonorsView(),
      binding: FavDonorsBinding(),
    ),
    GetPage(
      name: _Paths.BLOOD_GROUP_SEARCH_TAB,
      page: () => const BloodGroupSearchTabView(),
      binding: BloodGroupSearchTabBinding(),
    ),
    GetPage(
      name: _Paths.LOCATION_SEARCH_TAB,
      page: () => const LocationSearchTabView(),
      binding: LocationSearchTabBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_THEMES,
      page: () => const ChangeThemesView(),
      binding: ChangeThemesBinding(),
    ),
    GetPage(
      name: _Paths.HELP_QUESTION,
      page: () => const HelpQuestionView(),
      binding: HelpQuestionBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_OTP,
      page: () => const VerifyOtpView(),
      binding: VerifyOtpBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT,
      page: () => const ContactView(),
      binding: ContactBinding(),
    ),
  ];
}
