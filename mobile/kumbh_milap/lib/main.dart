import 'package:flutter/material.dart';
import 'package:kumbh_milap/app_theme.dart';
import 'package:kumbh_milap/presentation/providers/language_provider.dart';
import 'package:kumbh_milap/presentation/providers/profile_provider.dart';
import 'package:kumbh_milap/presentation/screens/create_profile_screen.dart';
import 'package:kumbh_milap/presentation/screens/home_screen.dart';
import 'package:kumbh_milap/presentation/screens/login_screen.dart';
import 'package:kumbh_milap/presentation/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'core/shared_pref.dart';
import 'data/auth_repository.dart';
import 'domain/auth_use.dart';
import 'presentation/providers/auth_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'presentation/screens/lang_select_screen.dart';
import 'presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPrefs = SharedPrefs();
  final authRepo = AuthRepository();
  final authUseCase = AuthUseCase(authRepo, sharedPrefs);

  final String? savedLang = await sharedPrefs.getLanguage();
  runApp(MyApp(
      savedLang: savedLang,
      authUseCase: authUseCase,
      sharedPrefs: sharedPrefs));
}

class MyApp extends StatelessWidget {
  final String? savedLang;
  final AuthUseCase authUseCase;
  final SharedPrefs sharedPrefs;

  MyApp(
      {required this.savedLang,
      required this.authUseCase,
      required this.sharedPrefs});
  @override
  Widget build(BuildContext context) {
    // final languageProvider = Provider.of<LanguageProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(authUseCase)),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) {
          final provider = LanguageProvider(sharedPrefs);
          provider.loadLanguage();
          return provider;
        }),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return MaterialApp(
            title: 'Kumbh Milap',
            theme: AppTheme.lightTheme,
            locale: languageProvider.locale,
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
              "/langSelect": (context) => LanguageScreen(),
            },
          );
        },
      ),
    );
  }
}
