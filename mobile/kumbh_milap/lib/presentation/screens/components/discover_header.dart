import 'package:flutter/material.dart';
import 'package:kumbh_milap/presentation/screens/components/discover_button.dart';

class DiscoverHeader extends StatelessWidget {
  final String profilePhoto;
  final VoidCallback onLikePressed;
  final VoidCallback onDislikePressed;
  final String label;

  const DiscoverHeader({
    Key? key,
    required this.profilePhoto,
    required this.onLikePressed,
    required this.onDislikePressed,
    required this.label,
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
      child: label != 'Liked'
          ? Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(0.4, 1.25),
                  child: DiscoverButton(
                      onPressed: onDislikePressed, label: 'Connect'),
                ),
                Align(
                  alignment: AlignmentDirectional(-0.4, 1.25),
                  child: DiscoverButton(
                      onPressed: onDislikePressed, label: 'Cross'),
                ),
              ],
            )
          : null,
    );
  }
}
