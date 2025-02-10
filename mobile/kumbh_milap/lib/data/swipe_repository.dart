
import 'dart:convert';
import 'dart:math';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:kumbh_milap/core/error.dart';
import 'package:kumbh_milap/core/model/profile_model.dart';
import 'package:kumbh_milap/core/shared_pref.dart';
import 'package:kumbh_milap/utils/constants.dart';

class SwipeRepository {
  final String baseUrl = "$BACKEND_URL/swipe";


  Future<bool> swipeRight(String userId) async {
    String? token = await SharedPrefs().getAccessToken();
    
    if (token == null) {
      throw Exception('Token not found');
    }
    
    final response = await http.post(
      Uri.parse('$baseUrl/right'),
      body: jsonEncode({'user_id': userId}),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${token}"
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      final responseBody = jsonDecode(response.body);
      throw Exception(responseBody['data']['message'].toString());
    }
  }

  Future<bool> swipeLeft(String userId) async {
    String? token = await SharedPrefs().getAccessToken();
    
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/left'),
      body: jsonEncode({'user_id': userId}),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${token}"
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      final responseBody = jsonDecode(response.body);
      throw Exception(responseBody['data']['message'].toString());
    }
  }

  Future<Either<Error, List<ProfileModel>>> getSwipes() async {
    String? token = await SharedPrefs().getAccessToken();

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${token}"
      },

    );

    if (response.statusCode == 200) {
      final responseBody =  jsonDecode(response.body);
      try {
        return Right(parseProfileList(responseBody['data']));
      } catch (e) {
        return Left(ParsingError(e.toString()));
      }
    } else {
      final responseBody = jsonDecode(response.body);
      throw Exception(responseBody['data']['message'].toString());
    }
  }

  Future<Either<Error, List<ProfileModel>>> getMatches() async {
    String? token = await SharedPrefs().getAccessToken();

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/matches'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${token}"
      },

    );

    if (response.statusCode == 200) {
      final responseBody =  jsonDecode(response.body);
      try {
        return Right(parseProfileList(responseBody['data']));
      } catch (e) {
        return Left(ParsingError(e.toString()));
      }
    } else {
      final responseBody = jsonDecode(response.body);
      throw Exception(responseBody['data']['message'].toString());
    }
  }

  Future<Either<Error, List<ProfileModel>>> getLikes() async {
    String? token = await SharedPrefs().getAccessToken();
    
    if (token == null) {
      return Left(UnAuthenticated());
    }

    final response = await http.get(
      Uri.parse('$baseUrl/likes'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer ${token}"
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      try {
        return Right(parseProfileList(responseBody['data']));
      } catch (e) {
        return Left(ParsingError(e.toString()));
      }
    } else {
      final responseBody = jsonDecode(response.body);
      return Left(NetworkError(responseBody['data']['message'].toString()));
    }
  }

  List<ProfileModel> parseProfileList(List<dynamic> list) {
    return list.map((e) => ProfileModel.fromJson(e)).toList();
  }
}