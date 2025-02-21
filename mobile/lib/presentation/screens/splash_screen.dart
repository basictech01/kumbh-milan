import 'package:flutter/material.dart';
import 'package:kumbh_milap/presentation/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLangauageAndAccess();
  }

  Future<void> _checkLangauageAndAccess() async {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // Fetch stored language
    bool isSelected = await languageProvider.loadLanguage();
    bool isLoggedIn = await authProvider.isLoggedIn();
    await Future.delayed(Duration(seconds: 2));

    if (isSelected && isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/home'); // Go to Login
    } else if (isSelected) {
      Navigator.pushReplacementNamed(
          context, '/login'); // Go to Language Selection
    } else {
      Navigator.pushReplacementNamed(
          context, '/langSelect'); // Go to Language Selection
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/sadhu.png',
              width: 250,
              height: 240,
            ),
            Text(
              AppLocalizations.of(context)!.appName, // Localized app name
              style: TextStyle(
                fontSize: 36,
                fontFamily: 'Gotham',
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
