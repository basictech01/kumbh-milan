import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:kumbh_milap/core/model/profile_model.dart';
import '../core/shared_pref.dart';

class ProfileRepository {
  final String baseUrl = "http://10.0.2.2:3001/profile";

  Future<Map<String, dynamic>> createProfile(ProfileModel profile) async {
    String? token = await SharedPrefs().getAccessToken();

    if (token == null) {
      throw Exception('Token not found');
    }

    Map<String, dynamic> profileData = profile.toJson();
    profileData.removeWhere((key, value) => value == null);

    print("Request Payload: ${jsonEncode(profileData)}");

    final response = await http.put(
      Uri.parse('$baseUrl/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${token}"
      },
      body: utf8.encode(jsonEncode(profileData)),
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 201) {
      print(responseData);
      return responseData;
    } else {
      print(responseData);
      throw Exception(responseData);
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

  Future<String?> uploadProfilePhoto(File imageFile) async {
    String? token = await SharedPrefs().getAccessToken();

    if (token == null) {
      throw Exception('Token not found');
    }
    try {
      var request = http.MultipartRequest(
          "POST", Uri.parse("$baseUrl/upload_image"))
        ..headers['Authorization'] = "Bearer $token"
        ..files.add(await http.MultipartFile.fromPath("photo", imageFile.path));

      var response = await request.send();
      if (response.statusCode == 200) {
        final responseData = jsonDecode(await response.stream.bytesToString());
        return responseData['data']['url'];
      } else {
        print("Upload failed: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>> updateProfile(ProfileModel profile) async {
    String? token = await SharedPrefs().getAccessToken();

    if (token == null) {
      throw Exception('Token not found');
    }

    Map<String, dynamic> profileData = profile.toJson();
    profileData.removeWhere((key, value) => value == null);

    print("Request Payload: ${jsonEncode(profileData)}");

    final response = await http.put(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${token}"
      },
      body: utf8.encode(jsonEncode(profileData)),
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print(responseData);
      return responseData;
    } else {
      print(responseData);
      throw Exception(responseData);
    }
  }
}
