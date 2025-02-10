import 'package:flutter/material.dart';
import 'package:kumbh_milap/presentation/screens/components/custom_button.dart';

import '../../../app_theme.dart';

class ProfileHeader extends StatelessWidget {
  final String? profilePhoto;
  final String name;
  final bool isMatched;

  const ProfileHeader({
    Key? key,
    this.profilePhoto,
    required this.name,
    this.isMatched = false,
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
                    : Image.network(
                        profilePhoto!,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Icon(Icons.error,
                              size: 50, color: AppTheme.primaryColor);
                        },
                      ),
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
                // Add a condition here
                if (isMatched)
                  IconButton(
                    icon: Icon(Icons.call, color: AppTheme.primaryColor),
                    onPressed: () {},
                  )
                else
                  CustomButton(text: 'Say Hi', onPressed: () {}),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}
