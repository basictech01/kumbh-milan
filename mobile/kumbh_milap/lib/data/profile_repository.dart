import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kumbh_milap/core/model/profile_model.dart';
import '../core/shared_pref.dart';

class ProfileRepository {
  final String baseUrl = "http://10.0.2.2:3001/profile";

  Future<int> createProfile(ProfileModel profile) async {
    String? token = await SharedPrefs().getAccessToken();

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/'),
      body: jsonEncode(profile),
      headers: {'Content-Type': 'application/json'},
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return responseData;
    } else {
      throw Exception(responseData.toString());
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    final response = await http.get(
      Uri.parse('$baseUrl'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final responseBody = jsonDecode(response.body);
      throw Exception(responseBody['data']['message'].toString());
    }
  }

  Future<String?> uploadProfilePhoto(String imagePath) async {
    final response = await http.post(
      Uri.parse('$baseUrl/upload_image'),
      body: jsonEncode({'image': imagePath}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      final responseBody = jsonDecode(response.body);
      throw Exception(responseBody['data']['message'].toString());
    } else {
      return jsonDecode(response.body)['data']['image_url'];
    }
  }

  Future<int> updateProfile(Map<String, dynamic> profile) async {
    final response = await http.put(
      Uri.parse('$baseUrl'),
      body: jsonEncode(profile),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      final responseBody = jsonDecode(response.body);
      throw Exception(responseBody['data']['message'].toString());
    }
  }
}
