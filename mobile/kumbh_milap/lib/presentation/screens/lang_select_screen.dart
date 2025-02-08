import 'package:flutter/material.dart';
import 'package:kumbh_milap/presentation/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import 'login_screen.dart';

class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kumbh Milap",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                languageProvider.setLanguage('en');
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => SplashScreen()));
              },
              child: Text("English"),
            ),
            ElevatedButton(
              onPressed: () {
                languageProvider.setLanguage('hi');
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => SplashScreen()));
              },
              child: Text("हिन्दी (Hindi)"),
            ),
          ],
        ),
      ),
    );
  }
}
