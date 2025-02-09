import 'package:flutter/material.dart';

import '../../../app_theme.dart';

class ProfileHeader extends StatelessWidget {
  final String username;
  final String? profilePhoto;
  final String name;

  const ProfileHeader({
    Key? key,
    required this.username,
    this.profilePhoto,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile Image Placeholder
        Stack(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              color: AppTheme.lightGray, // Placeholder background
              child: Center(
                child: profilePhoto == null
                    ? Icon(Icons.person, size: 50, color: AppTheme.primaryColor)
                    : null,
              ),
            ),
          ],
        ),

        // Name
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  children: [
                    Text(name,
                        style: Theme.of(context).textTheme.displayMedium),
                    SizedBox(width: 3),
                    Icon(Icons.verified,
                        color: AppTheme.secondaryColor, size: 20),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.call, color: AppTheme.primaryColor),
                  onPressed: () {
                    // Handle call button press
                  },
                ),
              ]),
              Text(username, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }
}
