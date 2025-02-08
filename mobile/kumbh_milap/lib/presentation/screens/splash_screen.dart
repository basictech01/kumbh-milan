import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kumbh_milap/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';


import '../providers/language_provider.dart';
import 'package:kumbh_milap/presentation/providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _run();
  }

  Future<void> _run() async {
    // Check if language has been selected or not
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    bool isSelected = await languageProvider.loadLanguage();
    if (!isSelected) {
      Navigator.pushReplacementNamed(context, '/langSelect');
      return;
    }
    // Check if we hae permission to access the user's location
    bool locationPermission = await Permission.location.status.isGranted;
    if (!locationPermission) {
      // Check if user has permanently denied the permission
      bool isPermanentlyDenied = await Permission.location.isPermanentlyDenied;
      if (isPermanentlyDenied) {
        Navigator.pushReplacementNamed(context, '/locationAccess');
        return;
      }

      // Request permission
      final status = await Permission.location.request();
      if (status.isDenied) {
        Navigator.pushReplacementNamed(context, '/locationAccess');
        return;
      }
    }

    // Check if user is in 10KM radius of the Kumbh Mela
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
    );

    double distance = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      SANGAM_LOCATION_LATITUDE,
      SANGAM_LOCATION_LONGITUDE,
    );

    if (distance > 10000) {
      Navigator.pushReplacementNamed(context, '/locationAccess');
      return;
    }

    
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    bool isLoggedIn = await authProvider.isLoggedIn();
    await Future.delayed(Duration(seconds: 2));

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, '/home'); // Go to Login
      return;
    }
    Navigator.pushReplacementNamed(context, '/login'); // Go to Language Selection
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Text(
          AppLocalizations.of(context)!.appName, // Localized app name
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }
}
