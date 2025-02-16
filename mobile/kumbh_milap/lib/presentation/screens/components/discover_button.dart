import 'package:flutter/material.dart';

import '../../../app_theme.dart';

class DiscoverButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const DiscoverButton({
    Key? key,
    required this.onPressed,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 30),
          shape: CircleBorder(),
        ),
        child: label == 'Connect'
            ? Icon(
                Icons.favorite,
                color: AppTheme.primaryColor,
                size: 35,
              )
            : Icon(
                Icons.close,
                color: AppTheme.primaryColor,
                size: 35,
              ),
      ),
    );
  }
}
