import 'package:flutter/material.dart';
import 'package:kumbh_milap/app_theme.dart';
import 'package:kumbh_milap/presentation/providers/language_provider.dart';
import 'package:kumbh_milap/presentation/providers/user_provider.dart';
import 'package:kumbh_milap/presentation/screens/create_profile_screen.dart';
import 'package:kumbh_milap/presentation/screens/home_screen.dart';
import 'package:kumbh_milap/presentation/screens/login_screen.dart';
import 'package:kumbh_milap/presentation/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'presentation/providers/auth_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'presentation/screens/lang_select_screen.dart';
import 'presentation/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final languageProvider = Provider.of<LanguageProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider())
      ],
      child: MaterialApp(
        title: 'Kumbh Milap',
        theme: AppTheme.lightTheme,
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'), // English
          Locale('hi'), // Spanish
        ],
        initialRoute: "/splash",
        routes: {
          "/login": (context) => const LoginScreen(),
          "/signup": (context) => const SignUpScreen(),
          "/home": (context) => const HomeScreen(),
          "/createProfile": (context) => const CreateProfileScreen(),
          "/splash": (context) => const SplashScreen(),
          "/langSelect": (context) => const LanguageSelectionScreen(),
        },
      ),
    );
  }
}
