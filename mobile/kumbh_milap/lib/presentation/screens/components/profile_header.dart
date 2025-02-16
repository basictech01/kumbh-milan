import 'package:flutter/material.dart';
import 'package:kumbh_milap/presentation/screens/components/discover_button.dart';

class ProfileHeader extends StatelessWidget {
  final String profilePhoto;

  const ProfileHeader({
    Key? key,
    required this.profilePhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        image: DecorationImage(
          image: NetworkImage(profilePhoto),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
