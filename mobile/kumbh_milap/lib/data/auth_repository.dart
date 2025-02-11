import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kumbh_milap/utils/constants.dart';

import '../core/shared_pref.dart';
import '../utils/custom_exception.dart';
import '../utils/error_messages.dart';

class AuthRepository {
  final String baseUrl = "$BACKEND_URL/auth"; // Replace with your API URL

  Future<Map<String, dynamic>> login(
      String username, String password, BuildContext context) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: jsonEncode({'username': username, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final responseBody = jsonDecode(response.body);
      switch (response.statusCode) {
        case 400:
          throw CustomException(ErrorMessages.loginFailed(context));
        case 401:
          throw CustomException(ErrorMessages.loginFailed(context));
        case 404:
          throw CustomException(ErrorMessages.userNotFound(context));
        case 500:
          throw CustomException(ErrorMessages.serverError(context));
        default:
          throw CustomException(responseBody['data']['message'].toString());
      }
    }
  }

  Future<Map<String, dynamic>> signup(String username, String password,
      String name, String phone, BuildContext context) async {
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
      print(response.statusCode);
      switch (response.statusCode) {
        case 400:
          throw CustomException(ErrorMessages.userNameAlreadyExists(context));
        case 401:
          throw CustomException(ErrorMessages.unknownError(context));
        case 500:
          throw CustomException(ErrorMessages.serverError(context));
        default:
          throw CustomException(responseBody['data']['message'].toString());
      }
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
      throw Exception(responseBody['data']['message'].toString());
    }
  }
}
