import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../utils/constants/app_config.dart';
import '../../profile/controllers/profile_controller.dart';

class ProfileDetailsController extends GetxController {
  final ProfileController profileC = Get.find<ProfileController>();

  @override
  void onInit() {
    super.onInit();
    profileC.profile();
  }

  int? get id => profileC.userData.value.id;
  String? get name => profileC.userData.value.name;
  String? get phone => profileC.userData.value.phone;
  String? get email => profileC.userData.value.email;
  String? get facebookLink => profileC.userData.value.facebookLink;
  String? get details => profileC.userData.value.details;
  String? get division => profileC.userData.value.division;
  String? get district => profileC.userData.value.district;
  String? get upazila => profileC.userData.value.upazila;
  String? get fullAddress => profileC.userData.value.fullAddress;

  String? get userType => profileC.userData.value.userType;

  String? get lastDonationDate =>
      formatBanglaDateTime(profileC.userData.value.lastDonationDate);

  String? get createdAt =>
      formatBanglaDateTime(profileC.userData.value.createdAt);

  String? get updatedAt =>
      formatBanglaDateTime(profileC.userData.value.updatedAt);



  String? get blood => profileC.userData.value.blood;

  String? get profileImage => profileC.userData.value.profileImage;

  String? get profileImageUrl {
    if (profileImage == null || profileImage!.isEmpty) {
      return null;
    }
    return "${AppConfig.baseUrl}$profileImage";
  }

  bool get isLoading => profileC.isLoading.value;



  String? formatBanglaDateTime(String? date) {
    if (date == null) return null;
    final parsed = DateTime.parse(date);
    final datePart = DateFormat("dd MMMM yyyy", "bn").format(parsed);
    final timePart = DateFormat("a h:mm", "bn").format(parsed);
    return "$datePart" + " " + "$timePart";
  }


}