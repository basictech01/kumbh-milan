import 'package:flutter/material.dart';
import 'package:kumbh_milap/core/model/profile_model.dart';
import 'package:kumbh_milap/data/swipe_repository.dart';
import 'package:kumbh_milap/presentation/providers/match_provider.dart';

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

  MatchState _matchState = MatchState.initial;
  MatchState get matchState => _matchState;

  Future<void> getMatches() async {
    _likeState = LikeState.loading;
    notifyListeners();

    final result = await swipeRepository.getLikes();

    result.fold(
        (error) => {
              print(error),
              _likeState = LikeState.error,
            },
        (matches) => {_matches = matches, _likeState = LikeState.loaded});
    notifyListeners();
  }

  Future<void> matchNow(int? userID) async {
    _matchState = MatchState.loading;
    notifyListeners();

    if (userID == null) {
      _matchState = MatchState.error;
      notifyListeners();
      return;
    }
    try {
      await swipeRepository.swipeRight(userID);
      _matchState = MatchState.loaded;
    } catch (e) {
      print(e);
      _matchState = MatchState.error;
    }
  }
}
