import 'dart:convert';
import 'package:blood_donation_app/app/utils/constants/api_url.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordService {



  Future<void> forgotPassword(String email) async {
    final url = Uri.parse(ApiUrl.forgotPassword);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data['message']);
    } else {
      print('Error: ${response.body}');
    }
  }

  Future<http.Response> verifyOtp(String email, String otp) async {
    final url = Uri.parse(ApiUrl.verifyOtp);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': otp}),
    );

    return response;
  }

  Future<void> resetPassword(
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    final url = Uri.parse(ApiUrl.resetPassword);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }),
    );

    if (response.statusCode == 200) {
      print('Password reset successful');
    } else {
      print('Error: ${response.body}');
    }
  }




}
