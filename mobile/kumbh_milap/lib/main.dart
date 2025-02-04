import 'package:flutter/material.dart';
import 'package:kumbh_milap/app_theme.dart';
import 'package:kumbh_milap/presentation/providers/user_provider.dart';
import 'package:kumbh_milap/presentation/screens/create_profile_screen.dart';
import 'package:kumbh_milap/presentation/screens/home_screen.dart';
import 'package:kumbh_milap/presentation/screens/login_screen.dart';
import 'package:kumbh_milap/presentation/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/screens/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Kumbh Milap',
        theme: AppTheme.lightTheme,
        initialRoute: "/login",
        routes: {
          "/login": (context) => const LoginScreen(),
          "/signup": (context) => const SignUpScreen(),
          "/home": (context) => const HomeScreen(),
          "/createProfile": (context) => const CreateProfileScreen(),
        },
      ),
    );
  }
}
