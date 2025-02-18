import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.termsAndConditions,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        //change the back button color
        iconTheme:
            IconThemeData(color: Theme.of(context).scaffoldBackgroundColor),
      ),
      body: Center(
        child: Text('Hello, World!'),
      ),
    );
  }
}
