import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _name = "";
  String _username = "";
  String _email = "";
  int _age = 0;
  String _gender = "";
  String _bio = "";
  String? _profilePhoto;
  String _number = "";

  String get name => _name;
  String get username => _username;
  String get email => _email;
  int get age => _age;
  String get gender => _gender;
  String get bio => _bio;
  String get number => _number;
  String? get profilePhoto => _profilePhoto;

  void updateEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void updateName(String value) {
    _name = value;
    notifyListeners();
  }

  void updateUsername(String value) {
    _username = value;
    notifyListeners();
  }

  void updateAge(String value) {
    _age = int.tryParse(value) ?? 0;
    notifyListeners();
  }

  void updateGender(String value) {
    _gender = value;
    notifyListeners();
  }

  void updatePhoneNumber(String value) {
    _number = value;
    notifyListeners();
  }

  void updateBio(String value) {
    _bio = value;
    notifyListeners();
  }

  void updateProfilePhoto(String? imagePath) {
    _profilePhoto = imagePath;
    notifyListeners();
  }

  Future<bool> createProfile() async {
    // Add create profile logic here
    return true;
  }
}
