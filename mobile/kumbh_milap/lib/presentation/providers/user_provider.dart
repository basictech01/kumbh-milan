import 'dart:ffi';

import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _name = "";
  String _username = "";
  int _age = 0;
  String _gender = "";
  String _bio = "";
  String? _profilePhoto;
  String _home = "";
  String _occupation = "";
  String _education = "";
  String? _subgroup = "";
  String _lookingFor = "";
  String _advice = "";
  String _meaningOfLife = "";
  String _achievements = "";
  String _challenges = "";
  List<String> _interests = [];
  List<String> _languages = [];

  String get name => _name;
  String get username => _username;
  int get age => _age;
  String get gender => _gender;
  String get bio => _bio;
  String? get profilePhoto => _profilePhoto;
  String get home => _home;
  String get occupation => _occupation;
  String get education => _education;
  String? get subgroup => _subgroup;
  String get lookingFor => _lookingFor;
  String get advice => _advice;
  String get meaningOfLife => _meaningOfLife;
  String get achievements => _achievements;
  String get challenges => _challenges;
  List<String> get interests => _interests;
  List<String> get languages => _languages;

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

  void updateBio(String value) {
    _bio = value;
    notifyListeners();
  }

  void updateProfilePhoto(String? imagePath) {
    _profilePhoto = imagePath;
    notifyListeners();
  }

  void updateHome(String value) {
    _home = value;
    notifyListeners();
  }

  void updateOccupation(String value) {
    _occupation = value;
    notifyListeners();
  }

  void updateEducation(String value) {
    _education = value;
    notifyListeners();
  }

  void updateSubgroup(String? value) {
    _subgroup = value;
    notifyListeners();
  }

  void updateLookingFor(String value) {
    _lookingFor = value;
    notifyListeners();
  }

  void addInterest(String value) {
    _interests.add(value);
    notifyListeners();
  }

  void removeInterest(String value) {
    _interests.remove(value);
    notifyListeners();
  }

  void addLanguage(String value) {
    _languages.add(value);
    notifyListeners();
  }

  void removeLanguage(String value) {
    _languages.remove(value);
    notifyListeners();
  }

  void updateAdvice(String value) {
    _advice = value;
    notifyListeners();
  }

  void updateMeaningOfLife(String value) {
    _meaningOfLife = value;
    notifyListeners();
  }

  void updateAchievements(String value) {
    _achievements = value;
    notifyListeners();
  }

  void updateChallenges(String value) {
    _challenges = value;
    notifyListeners();
  }

  Future<bool> createProfile() async {
    // Add create profile logic here
    return true;
  }
}
