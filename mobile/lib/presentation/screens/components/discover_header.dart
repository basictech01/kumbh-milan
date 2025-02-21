import 'package:flutter/material.dart';
import 'package:kumbh_milap/presentation/screens/components/discover_button.dart';
import 'location_badge.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiscoverHeader extends StatelessWidget {
  final String? profilePhoto;
  final VoidCallback onLikePressed;
  final VoidCallback onDislikePressed;
  final VoidCallback onActionButtonPressed;
  final String label;
  final String? location;

  const DiscoverHeader({
    Key? key,
    required this.profilePhoto,
    required this.onLikePressed,
    required this.onDislikePressed,
    required this.label,
    required this.location,
    required this.onActionButtonPressed,
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
          image: profilePhoto != null
              ? NetworkImage(profilePhoto!)
              : AssetImage('assets/sadhu.png') as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
      child: label == 'Discover'
          ? Stack(
              children: [
                if (location != null)
                  Align(
                    alignment: AlignmentDirectional(0.97, -0.80),
                    child: LocationBadge(location: location!),
                  ),
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
          : Stack(
              children: [
                if (location != null)
                  Align(
                    alignment: AlignmentDirectional(0.97, -0.80),
                    child: LocationBadge(location: location!),
                  ),
                Align(
                  alignment: AlignmentDirectional(0, 1.15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        minimumSize: const Size(150, 45)),
                    onPressed: onActionButtonPressed,
                    child: Text(
                      label == 'Likes'
                          ? AppLocalizations.of(context)!.doMatch
                          : AppLocalizations.of(context)!.callNow,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-0.97, -0.85),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.arrow_back,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
