import 'dart:convert';

import 'package:blood_donation_app/app/data/model/post.dart';
import 'package:blood_donation_app/app/data/seassion/auth_seassion.dart';
import 'package:blood_donation_app/app/utils/constants/api_url.dart';
import 'package:http/http.dart' as http;

class BloodServices {
  Future<http.Response> bloodPostCreate(Map<String, dynamic> postData) async {
    final AuthSeassion authSeassion = AuthSeassion();
    final token = await authSeassion.getToken();

    try {
      final url = Uri.parse(ApiUrl.bloodPost);
      final body = jsonEncode(postData);

      final response = await http.post(
        url,
        body: body,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );



      return response;
    } catch (e) {

      throw Exception("Something went wrong : $e");
    }
  }

  Future<http.Response> bloodPostShow() async {
    final AuthSeassion authSeassion = AuthSeassion();
    final token = await authSeassion.getToken();

    try {
      final url = Uri.parse(ApiUrl.myBlood);

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      return response;
    } catch (e) {
      throw Exception("Something went wrong : $e");
    }
  }

  Future<http.Response> bloodUpdate(String id, Map<String, dynamic> postData) async {
    final AuthSeassion authSeassion = AuthSeassion();
    final token = await authSeassion.getToken();

    try {
      final url = Uri.parse("${ApiUrl.bloodUpdate}$id");

      final body = jsonEncode(postData);

      final response = await http.put(
        url,
        body: body,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );



      return response;

    } catch (e) {

      throw Exception("Something went wrong : $e");
    }
  }

  Future<http.Response> bloodDelete(String id) async {
    final AuthSeassion authSeassion = AuthSeassion();
    final token = await authSeassion.getToken();

    try {
      final url = Uri.parse("${ApiUrl.bloodDelete}$id");

      final response = await http.delete(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",

        },
      );

      return response;

    } catch (e) {
      throw Exception("Something went wrong : $e");
    }
  }



  Future<http.Response> allBloodRequest() async {

    try {
      final url = Uri.parse(ApiUrl.allBlood);

      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      return response;
    } catch (e) {
      print(e.toString());
      throw Exception("Something went wrong : $e");
    }
  }


  Future<http.Response> statusBloodRequest() async {

    try {
      final url = Uri.parse("${ApiUrl.bloodStatus}সফল");


      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      return response;
    } catch (e) {
      throw Exception("Something went wrong : $e");
    }
  }




}
