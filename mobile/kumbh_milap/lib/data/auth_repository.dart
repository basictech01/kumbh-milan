import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepository {
  final String baseUrl =
      "http://10.0.2.2:3001/auth"; // Replace with your API URL

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
}
