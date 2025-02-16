import 'package:flutter/material.dart';
import 'package:kumbh_milap/core/model/profile_model.dart';
import '../components/discover_header.dart';
import '../components/profile_info.dart';
import '../components/profile_additional_info.dart';
import '../components/profile_info_section.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class DetailPage extends StatelessWidget {
  final ProfileModel profileModel;

  const DetailPage({Key? key, required this.profileModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            DiscoverHeader(
              profilePhoto:
                  profileModel.profilePictureUrl ?? '/placeholder.jpg',
              onLikePressed: () {},
              onDislikePressed: () {},
              label: 'Liked',
            ),
            const SizedBox(height: 30),
            ProfileInfo(
              name: profileModel.name,
              age: profileModel.age,
              gender: profileModel.gender,
              education: profileModel.education,
              occupation: profileModel.occupation,
              location: profileModel.home,
              subGroup: profileModel.subgroup,
            ),
            const SizedBox(height: 20),
            InterestsSection(
              interests: profileModel.interests ?? [],
              languages: profileModel.languages ?? [],
            ),
            const SizedBox(height: 20),
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
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
                onPressed: () {},
                child: Text(
                  AppLocalizations.of(context)!.doMatch,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
