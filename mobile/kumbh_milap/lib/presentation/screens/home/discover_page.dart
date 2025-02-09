import 'package:flutter/material.dart';
import '../components/discover_card.dart';

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: UserProfileCard(
          name: 'Frances McKnight',
          distance: '2 km away',
          funFact: 'Some text here',
          onBack: () => Navigator.pop(context),
          onShare: () => print('Share pressed'),
          onMore: () => print('More options pressed'),
          onHighFive: () => print('High five pressed'),
          onSayHi: () => print('Say hi pressed'),
        ),
      ),
    );
  }
}
