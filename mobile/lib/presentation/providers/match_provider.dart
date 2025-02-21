import 'package:flutter/material.dart';
import 'package:kumbh_milap/core/model/profile_model.dart';
import 'package:kumbh_milap/data/swipe_repository.dart';

enum MatchState {
  initial,
  loading,
  loaded,
  error,
}

class MatchProvider extends ChangeNotifier {
  final SwipeRepository swipeRepository = SwipeRepository();

  List<ProfileModel> _matches = [];
  List<ProfileModel> get matches => _matches;

  MatchState _matchState = MatchState.initial;
  MatchState get matchState => _matchState;


  Future<void> getMatches() async {
    _matchState = MatchState.loading;
    notifyListeners();

    final result = await swipeRepository.getMatches();
    
    result.fold((error) => {
      print(error),
      _matchState = MatchState.error,
    }, (matches) => {
      _matches = matches,
      _matchState = MatchState.loaded
    });
    notifyListeners();
  }
}