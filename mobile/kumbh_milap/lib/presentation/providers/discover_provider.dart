import 'package:flutter/material.dart';
import 'package:either_dart/either.dart';
import 'package:kumbh_milap/core/error.dart';
import 'package:kumbh_milap/core/model/profile_model.dart';
import '../../data/swipe_repository.dart';

class DiscoverProvider extends ChangeNotifier {
  final SwipeRepository swipeRepository = SwipeRepository();
  List<ProfileModel> _profiles = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ProfileModel> get profiles => _profiles;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProfiles() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await swipeRepository.getSwipes();
    result.fold(
      (error) {
        _errorMessage = error.message;
      },
      (profiles) {
        _profiles = profiles;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> swipeRight(String userId) async {
    try {
      await swipeRepository.swipeRight(userId);
      _profiles.removeWhere((profile) => profile.user_id == userId);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> swipeLeft(String userId) async {
    try {
      await swipeRepository.swipeLeft(userId);
      _profiles.removeWhere((profile) => profile.user_id == userId);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
