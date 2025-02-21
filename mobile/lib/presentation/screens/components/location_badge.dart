import 'package:flutter/material.dart';
import 'package:kumbh_milap/app_theme.dart';

class LocationBadge extends StatelessWidget {
  final String location;

  const LocationBadge({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).primaryColor),
      ),
      child: IntrinsicWidth(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.home, color: AppTheme.black, size: 18),
            SizedBox(width: 5),
            Text(location,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: AppTheme.black)),
          ],
        ),
      ),
    );
  }
}
