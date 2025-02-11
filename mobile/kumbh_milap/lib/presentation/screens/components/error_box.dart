import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

void showErrorDialog(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          AppLocalizations.of(context)!.error,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        content: Text(
          errorMessage,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              AppLocalizations.of(context)!.ok,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
