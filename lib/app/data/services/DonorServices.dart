import 'dart:convert';

import 'package:blood_donation_app/app/utils/constants/api_url.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants/app_config.dart';
import '../model/donor.dart';

class DonorServices {
  Future<http.Response> allDonors() async {
    try {
      final url = Uri.parse(ApiUrl.donor);
      final response = http.get(url);

      return response;
    } catch (e) {
      throw Exception("Something went wrong : $e");
    }
  }

  static Future<List<Donors>> getDonorsByBlood(String blood) async {
    final url = Uri.parse('${ApiUrl.donorsByBlood}$blood');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final donors = (data['donors'] as List)
          .map((json) => Donors.fromJson(json))
          .toList();
      return donors;
    } else {
      throw Exception('Failed to load donors');
    }
  }

  Future<List<Donors>> getDonorsByLocation({
    String? blood,
    String? division,
    String? district,
    String? upazila,
  }) async {
    final String bloodParam = (blood == null || blood.isEmpty) ? 'all' : blood;
    final String divisionParam = (division == null || division.isEmpty)
        ? 'all'
        : division;
    final String districtParam = (district == null || district.isEmpty)
        ? 'all'
        : district;
    final String upazilaParam = (upazila == null || upazila.isEmpty)
        ? 'all'
        : upazila;

    final String encodedBlood = Uri.encodeComponent(bloodParam);
    final String encodedDivision = Uri.encodeComponent(divisionParam);
    final String encodedDistrict = Uri.encodeComponent(districtParam);
    final String encodedUpazila = Uri.encodeComponent(upazilaParam);

    final url = Uri.parse(
      '${AppConfig.baseUrl}/api/donors/$encodedBlood/$encodedDivision/$encodedDistrict/$encodedUpazila',
    );

    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final List list = data['donors'] ?? [];
        return list.map((e) => Donors.fromJson(e)).toList();
      } else {
        throw Exception('Server Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load donors: $e');
    }
  }
}
