import 'package:flutter/material.dart';
import 'package:kumbh_milap/presentation/screens/components/location_badge.dart';

class ProfileHeader extends StatelessWidget {
  final String? profilePhoto;
  final String? location;

  const ProfileHeader({
    Key? key,
    required this.profilePhoto,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            image: DecorationImage(
              image: profilePhoto != null
                  ? NetworkImage(profilePhoto!)
                  : AssetImage('assets/sadhu.png') as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (location != null)
          Positioned(
            bottom: 16,
            left: 16,
            child: LocationBadge(location: location!),
          ),
      ],
    );
  }
}
