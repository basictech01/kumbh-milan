import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../presentation/screens/components/error_box.dart';

class ConnectivityHelper {
  static Future<bool> checkInternetConnection(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      showErrorDialog(context, AppLocalizations.of(context)!.networkError);
      return false;
    }
    return true;
  }
}
