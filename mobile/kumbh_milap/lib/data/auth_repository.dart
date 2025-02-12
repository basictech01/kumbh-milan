import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kumbh_milap/utils/constants.dart';

import '../core/shared_pref.dart';

class AuthRepository {
  final String baseUrl = "$BACKEND_URL/auth"; // Replace with your API URL

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: jsonEncode({'username': username, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final responseBody = jsonDecode(response.body);
      throw Exception(responseBody['data']['message'].toString());
    }
  }

  Future<Map<String, dynamic>> signup(
      String username, String password, String name, String phone) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: jsonEncode({
        'name': name,
        'password': password,
        'username': username,
        'phone': phone
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      // print(response.body);
      return jsonDecode(response.body);
    } else {
      final responseBody = jsonDecode(response.body);
      throw Exception(responseBody['data']['message'].toString());
    }
  }

  Future<bool> refreshAccessToken() async {
    String? refreshToken = await SharedPrefs().getRefreshToken();

    if (refreshToken == null) {
      throw Exception('Refresh token not found');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/refresh'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $refreshToken"
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      await SharedPrefs().saveTokens(responseBody);
      return true;
    } else {
      final responseBody = jsonDecode(response.body);
      if (responseBody is Map && responseBody.containsKey('data')) {
        throw Exception(responseBody['data']['message'].toString());
      } else {
        throw Exception('Failed to refresh access token');
      }
    }
  }
}
