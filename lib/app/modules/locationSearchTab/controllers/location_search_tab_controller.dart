import 'package:get/get.dart';

import '../../../data/helpers/app_snackbar.dart';
import '../../../data/helpers/bd_location_data.dart';
import '../../../data/model/donor.dart';
import '../../../data/services/DonorServices.dart';

class LocationSearchTabController extends GetxController {


  final bloodGroups = const [
    "এ+",
    "এ-",
    "বি+",
    "বি-",
    "ও+",
    "ও-",
    "এবি+",
    "এবি-",
  ];

  final selectedBlood = RxnString();

  final selectedDivision = RxnString();
  final selectedDistrict = RxnString();
  final selectedUpazila = RxnString();

  final divisions = <String>[].obs;
  final districts = <String>[].obs;
  final upazilas = <String>[].obs;


  final donors = <Donors>[].obs;
    final isLoading = false.obs;

    final DonorServices donorService = DonorServices();


  @override
  void onInit() {
    super.onInit();
    divisions.assignAll(BdLocationData.divisions);
  }


  void onDivisionChanged(String? division, {bool resetSelected = true}) {
    selectedDivision.value = division;

    if (resetSelected) {
      selectedDistrict.value = null;
      selectedUpazila.value = null;
    }

    districts.clear();
    upazilas.clear();

    if (division == null || division.isEmpty) return;

    final dList =
        BdLocationData.divisionToDistricts[division] ?? const <String>[];

    districts.assignAll(dList.toSet().toList());
  }

  void onDistrictChanged(String? district, {bool resetSelected = true}) {
    selectedDistrict.value = district;

    if (resetSelected) {
      selectedUpazila.value = null;
    }

    upazilas.clear();

    final div = selectedDivision.value;
    if (div == null || div.isEmpty) return;
    if (district == null || district.isEmpty) return;

    final uList =
        BdLocationData.divisionDistrictUpazila[div]?[district] ??
            const <String>[];

    upazilas.assignAll(uList.toSet().toList());
  }

  void onUpazilaChanged(String? upazila) {
    selectedUpazila.value = upazila;
  }


  void searchLocation() async {
    isLoading.value = true;

    try {
      final result = await donorService.getDonorsByLocation(
        blood: selectedBlood.value,
        division: selectedDivision.value,
        district: selectedDistrict.value,
        upazila: selectedUpazila.value,
      );

      donors.assignAll(result);
    } catch (e) {
      donors.clear();
      showAppSnackbar(
        title: "Something went wrong",
        message: "Something went wrong",
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }

}
