import 'package:flutter/material.dart';
import 'package:kumbh_milap/presentation/providers/like_provider.dart';
import 'package:provider/provider.dart';

class LikeProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LikeProvider()..getMatches(), 
      child: Builder(builder: (context) {
        final likeProvider = Provider.of<LikeProvider>(context);
        switch (likeProvider.likeState) {
          case LikeState.initial:
            return Center(child: CircularProgressIndicator());
          case LikeState.loading:
            return Center(child: CircularProgressIndicator());
          case LikeState.loaded:
            return ListView.builder(
              itemCount: likeProvider.matches.length,
              itemBuilder: (context, index) {
                final match = likeProvider.matches[index];
                return Text(match.name!);
              },
            );
          case LikeState.error:
            return Center(child: Text('Error'));
        }
      }),
    );
  }
}