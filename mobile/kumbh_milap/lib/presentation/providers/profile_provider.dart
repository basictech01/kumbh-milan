import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kumbh_milap/core/model/profile_model.dart';
import '../../data/profile_repository.dart';
import '../../domain/profile_photo_use.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileRepository _profileRepo = ProfileRepository();
  final UploadProfilePhoto _uploadPhotoUseCase = UploadProfilePhoto();

  bool _isLoading = false;
  String? _error;
  Map<String, dynamic>? _profileData;
  ProfileModel? _profileModel;

  String? _username;
  String? _name;
  int? _age;
  String? _gender;
  String? _bio;
  String? _profilePhoto;
  String? _home;
  String? _occupation;
  String? _education;
  String? _subgroup;
  String? _lookingFor;
  String? _advice;
  String? _meaningOfLife;
  String? _achievements;
  String? _challenges;
  List<String> _interests = [];
  List<String> _languages = [];

  String? get username => _username;
  String? get name => _name;
  int? get age => _age;
  String? get gender => _gender;
  String? get bio => _bio;
  String? get profilePhoto => _profilePhoto;
  String? get home => _home;
  String? get occupation => _occupation;
  String? get education => _education;
  String? get subgroup => _subgroup;
  String? get lookingFor => _lookingFor;
  String? get advice => _advice;
  String? get meaningOfLife => _meaningOfLife;
  String? get achievements => _achievements;
  String? get challenges => _challenges;
  List<String> get interests => _interests;
  List<String> get languages => _languages;

  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<String, dynamic>? get profileData => _profileData;
  ProfileModel? get profileModel => _profileModel;

  void updateUsername(String value) {
    _username = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  void updateAge(String value) {
    _age = value.isNotEmpty ? int.tryParse(value) : null;
    notifyListeners();
  }

  void updateGender(String value) {
    _gender = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  void updateBio(String value) {
    _bio = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  void updateProfilePhoto(String value) {
    _profilePhoto = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  void updateHome(String value) {
    _home = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  void updateOccupation(String value) {
    _occupation = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  void updateEducation(String value) {
    _education = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  void updateSubgroup(String value) {
    _subgroup = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  void updateLookingFor(String value) {
    _lookingFor = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  void addInterest(String value) {
    _interests?.add(value);
    notifyListeners();
  }

  void removeInterest(String value) {
    _interests?.remove(value);
    notifyListeners();
  }

  void addLanguage(String value) {
    _languages?.add(value);
    notifyListeners();
  }

  void removeLanguage(String value) {
    _languages?.remove(value);
    notifyListeners();
  }

  void updateAdvice(String value) {
    _advice = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  void updateMeaningOfLife(String value) {
    _meaningOfLife = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  void updateAchievements(String value) {
    _achievements = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  void updateChallenges(String value) {
    _challenges = value.isNotEmpty ? value : null;
    notifyListeners();
  }

  //convert to profile model
  ProfileModel toProfileModel() {
    return ProfileModel(
      age: _age,
      gender: _gender,
      about: _bio,
      profilePictureUrl: _profilePhoto,
      home: _home,
      occupation: _occupation,
      education: _education,
      subgroup: _subgroup,
      lookingFor: _lookingFor,
      advice: _advice,
      meaningOfLife: _meaningOfLife,
      achievements: _achievements,
      challenges: _challenges,
      interests: _interests,
      languages: _languages,
    );
  }

  Future<void> createProfile() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _profileRepo.createProfile(toProfileModel());
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> pickAndUploadProfilePhoto() async {
    _isLoading = true;
    notifyListeners();

    File? compressedImage = await _uploadPhotoUseCase.pickAndCompressImage();
    if (compressedImage == null) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    String? photoUrl = await _profileRepo.uploadProfilePhoto(compressedImage);
    if (photoUrl != null) {
      _profilePhoto = photoUrl;
      notifyListeners();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getProfile() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    // final userId = await SharedPrefs().getUserId();
    try {
      final response = await _profileRepo.getProfile();
      _profileModel = ProfileModel.fromJson(response['data']);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
