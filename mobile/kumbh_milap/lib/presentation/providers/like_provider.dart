import 'package:flutter/material.dart';
import 'package:kumbh_milap/core/model/profile_model.dart';
import 'package:kumbh_milap/data/swipe_repository.dart';

enum LikeState {
  initial,
  loading,
  loaded,
  error,
}

class LikeProvider extends ChangeNotifier {
  final SwipeRepository swipeRepository = SwipeRepository();

  List<ProfileModel> _matches = [];
  List<ProfileModel> get matches => _matches;

  LikeState _likeState = LikeState.initial;
  LikeState get likeState => _likeState;


  Future<void> getMatches() async {
    _likeState = LikeState.loading;
    notifyListeners();

    final result = await swipeRepository.getLikes();
    
    result.fold((error) => {
      print(error),
      _likeState = LikeState.error,
    }, (matches) => {
      _matches = matches,
      _likeState = LikeState.loaded
    });
    notifyListeners();
  }
}