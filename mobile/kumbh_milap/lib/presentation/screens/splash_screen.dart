import 'package:flutter/material.dart';
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
    _checkLanguageSelection();
  }

  Future<void> _checkLanguageSelection() async {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    bool isSelected = await languageProvider.isLanguageSelected();
    // bool isSelected = true;

    await Future.delayed(Duration(seconds: 2));

    if (isSelected) {
      Navigator.pushReplacementNamed(
          context, '/login'); // Navigate to login screen;
    } else {
      Navigator.pushReplacementNamed(
          context, '/langSelect'); // Navigate to language selection screen;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Text(
          AppLocalizations.of(context)!.appName,
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).scaffoldBackgroundColor),
        ),
      ),
    );
  }
}
