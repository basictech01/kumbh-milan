import 'package:flutter/material.dart';
import 'package:kumbh_milap/core/model/profile_model.dart';
import '../components/discover_header.dart';
import '../components/profile_info.dart';
import '../components/profile_additional_info.dart';
import '../components/profile_info_section.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class DetailPage extends StatelessWidget {
  final ProfileModel profileModel;
  final String labelPage;
  final VoidCallback onPressed;
  const DetailPage({
    Key? key,
    required this.profileModel,
    required this.labelPage,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            DiscoverHeader(
              profilePhoto: profileModel.profilePictureUrl,
              onLikePressed: () {},
              onDislikePressed: () {},
              label: labelPage,
              location: profileModel.home,
              onActionButtonPressed: onPressed,
            ),
            const SizedBox(height: 30),
            ProfileInfo(
              name: profileModel.name,
              age: profileModel.age,
              gender: profileModel.gender,
              education: profileModel.education,
              occupation: profileModel.occupation,
              subGroup: profileModel.subgroup,
            ),
            const SizedBox(height: 20),
            InterestsSection(
              interests: profileModel.interests ?? [],
              languages: profileModel.languages ?? [],
            ),
            InfoSection(information: {
              AppLocalizations.of(context)!.bio: profileModel.about,
            }),
            const SizedBox(height: 10),
            InfoSection(
              title: AppLocalizations.of(context)!.additionInfo,
              information: {
                AppLocalizations.of(context)!.lookingFor:
                    profileModel.lookingFor,
                AppLocalizations.of(context)!.advice: profileModel.advice,
                AppLocalizations.of(context)!.meaningOfLife:
                    profileModel.meaningOfLife,
                AppLocalizations.of(context)!.achievements:
                    profileModel.achievements,
                AppLocalizations.of(context)!.challenges:
                    profileModel.challenges,
              },
            ),
          ],
        ),
      ),
    );
  }
}
