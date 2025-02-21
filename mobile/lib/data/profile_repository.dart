import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:kumbh_milap/core/model/profile_model.dart';
import 'package:kumbh_milap/utils/constants.dart';
import '../core/shared_pref.dart';

class ProfileRepository {
  final String baseUrl = "$BACKEND_URL/profile";

  Future<Map<String, dynamic>> createProfile(ProfileModel profile) async {
    String? token = await SharedPrefs().getAccessToken();

    if (token == null) {
      throw Exception('Token not found');
    }

    Map<String, dynamic> profileData = profile.toJson();
    profileData.removeWhere((key, value) => value == null);

    // print("Request Payload: ${jsonEncode(profileData)}");

    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${token}"
      },
      body: utf8.encode(jsonEncode(profileData)),
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 201) {
      //fetch the user_id from the response and save it in shared prefs
      final userId = responseData['data']['user_id'];
      await SharedPrefs().addUserId(userId);
      // print(responseData);
      return responseData;
    } else {
      throw Exception(responseData);
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    int? id = await SharedPrefs().getUserId();
    String? token = await SharedPrefs().getAccessToken();
    if (token == null) {
      throw Exception('Token not found');
    }
    final response = await http.get(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token"
      },
    );

    if (response.statusCode == 200) {
      // print(response.body);
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
      Uri.parse('$baseUrl/update'),
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
