import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kumbh_milap/presentation/screens/splash_screen.dart';
import 'package:kumbh_milap/utils/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationAccessScreen extends StatefulWidget {
  @override
  _LocationAccessScreenState createState() => _LocationAccessScreenState();
}

enum LocationAccessState {
  LOADING,
  LOCATION_SERVICE_DISABLED,
  LOCATION_PERMISSION_PENDING,
  PERMANENTLY_DENIED,
  NOT_PRESENT_AT_KUMBH,
}

class _LocationAccessScreenState extends State<LocationAccessScreen> {
  
  LocationAccessState locationAccessState = LocationAccessState.LOADING;
  bool checking = false;
  @override
  void initState() {
    super.initState();
    checkState();
  }

  void checkState() async {
    setState(() {
      checking = true;
    });
    if (await Permission.location.serviceStatus.isDisabled) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.locationDisabled),
      ));
      return setState(() {
        locationAccessState = LocationAccessState.LOCATION_SERVICE_DISABLED;
        checking = false;
      });
    }

    if (await Permission.location.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.locationPermanentlyDeniedToast),
      ));
      return setState(() {
        locationAccessState = LocationAccessState.PERMANENTLY_DENIED;
        checking = false;
      });
    }


    if (await Permission.location.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.locationPendingToast),
      ));
      return setState(() {
        locationAccessState = LocationAccessState.LOCATION_PERMISSION_PENDING;
        checking = false;
      });
    }

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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.notPresentAtKumbhToast),
      ));
      return setState(() {
        locationAccessState = LocationAccessState.NOT_PRESENT_AT_KUMBH;
        checking = false;
      });
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SplashScreen()));
  }

  void requestLocationAccess() {
    Permission.location.request().then((status) {
      if (status.isDenied) {
        setState(() {
          locationAccessState = LocationAccessState.LOCATION_PERMISSION_PENDING;
        });
      } else {
        checkState();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children;
    switch (locationAccessState) {
      case LocationAccessState.LOADING:
        children = [CircularProgressIndicator()];
        break;
      case LocationAccessState.LOCATION_SERVICE_DISABLED:
        children = [
          Text(AppLocalizations.of(context)!.locationDisabled),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Geolocator.openLocationSettings(); 
            },
            child: Text(AppLocalizations.of(context)!.enableLocationService),
          ),
        ];
        break;
      case LocationAccessState.LOCATION_PERMISSION_PENDING:
        children = [
          Text(AppLocalizations.of(context)!.locationPending),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              requestLocationAccess();
            },
            child: Text(AppLocalizations.of(context)!.grantAccess),
          ),
        ];
        break;
      case LocationAccessState.PERMANENTLY_DENIED:
        children = [
          Text(AppLocalizations.of(context)!.locationPermanentlyDenied),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              openAppSettings();
            },
            child: Text(AppLocalizations.of(context)!.openSettings),
          ),
        ];
        break;
      case LocationAccessState.NOT_PRESENT_AT_KUMBH:
        children = [
          Text(AppLocalizations.of(context)!.notPresentAtKumbh,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
          ),
        ];
        break;
    }

    return Scaffold(
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.locationScreenTitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 160,
              child: Padding(padding: const EdgeInsets.all(4),
                child: ClipOval(
                  child: Image.asset('assets/sangam_point.png',
                    width: 320,
                    height: 320,
                    fit: BoxFit.cover,
                  ),
                )
              ),
            ),
            SizedBox(height: 20),
            ...children,
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: checking ? null : checkState,
              child: 
              Text(AppLocalizations.of(context)!.checkAgain)
              )
            ],
        ),
      ),
    );
  }
}

