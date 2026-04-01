import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../utils/constants/api_url.dart';
import '../seassion/auth_seassion.dart';

class AuthServices {
  Future<http.Response> register(Map<String, dynamic> userData) async {
    try {
      final url = Uri.parse(ApiUrl.register);
      final body = jsonEncode(userData);

      final response = await http.post(
        url,
        body: body,
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

  Future<http.Response> login(Map<String, dynamic> userData) async {
    try {
      final url = Uri.parse(ApiUrl.login);
      final body = jsonEncode(userData);

      final response = await http.post(
        url,
        body: body,
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

  Future<http.Response> profile() async {
    try {

     final AuthSeassion authSeassion = AuthSeassion();
      final token = await authSeassion.getToken();

      if (token == null) {
        throw Exception("Token not found");
      }

      final url = Uri.parse(ApiUrl.profile);

      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Authorization" : "Bearer $token"
        },
      );

      return response;
    } catch (e) {
      throw Exception("Something went wrong : $e");
    }
  }



  Future<http.Response> updateProfile(
      Map<String, dynamic> userData,
      File? profileImage,
      ) async {


    try {
      final url = Uri.parse(ApiUrl.update);

      final AuthSeassion authSeassion = AuthSeassion();
      final token = await authSeassion.getToken();

      final request = http.MultipartRequest("POST", url);

      request.headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });


      final Map<String, String> data = {
        "name": (userData["name"] ?? "").toString(),
        "phone": (userData["phone"] ?? "").toString(),
        "facebook_link": (userData["facebook_link"] ?? "").toString(),
        "details": (userData["details"] ?? "").toString(),
        "blood": (userData["blood"] ?? "").toString(),
        "division": (userData["division"] ?? "").toString(),
        "district": (userData["district"] ?? "").toString(),
        "upazila": (userData["upazila"] ?? "").toString(),
        "full_address": (userData["full_address"] ?? "").toString(),
        "last_donation_date": (userData["last_donation_date"] ?? "").toString(),
        "user_type": (userData["user_type"] ?? "").toString(),
      };


      request.fields.addAll(data);

      if (profileImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            "profile_image",
            profileImage.path,
          ),
        );
      }

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);
      return response;
    } catch (e) {
      throw Exception("Something went wrong : $e");
    }
  }



  Future<http.Response> delete() async {
    try {

      final AuthSeassion authSeassion = AuthSeassion();
      final token = await authSeassion.getToken();

       final url = Uri.parse(ApiUrl.delete);

      final response = await http.delete(
        url,
        headers: {
          "Authorization" : "Bearer $token",
          "Accept": "application/json",
        },
      );

      return response;
    } catch (e) {
      throw Exception("Something went wrong : $e");
    }
  }


  Future<http.Response> changePassword(Map<String,dynamic> password) async {
    try {

      final AuthSeassion authSeassion = AuthSeassion();
      final token = await authSeassion.getToken();

      final url = Uri.parse(ApiUrl.changePassword);

      final response = await http.post(
        url,
        body: jsonEncode(password),

        headers: {
          "Authorization" : "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
      );

      return response;
    } catch (e) {
      throw Exception("Something went wrong : $e");
    }
  }



  
  
}
