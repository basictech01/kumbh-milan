import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kumbh_milap/app_theme.dart';
import 'package:kumbh_milap/presentation/providers/profile_provider.dart';
import 'package:kumbh_milap/presentation/screens/home/discover_page.dart';
import 'package:kumbh_milap/presentation/screens/home/like_profile_page.dart';
import 'package:kumbh_milap/presentation/screens/home/match_profile_page.dart';
import 'package:kumbh_milap/presentation/screens/home/profile_page.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void initState() {
    super.initState();
    // Make status bar transparent
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().getProfile();
  });
  }

  static final List<Widget> _pages = <Widget>[
    LikeProfilePage(),
    DiscoverPage(),
    MatchProfilePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        bottomNavigationBar:
            BottomNavBar(currentIndex: _currentIndex, onTap: _onTap),
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
    );
  }
}

// Bottom Navigation Bar
class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const BottomNavBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      onTap: (index) {
        onTap(index);
      },
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.thumb_up),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.waving_hand),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sentiment_very_satisfied),
          label: '',
        ),
      ],
      selectedItemColor: AppTheme.primaryColor,
      unselectedItemColor: AppTheme.darkGray,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }
}
