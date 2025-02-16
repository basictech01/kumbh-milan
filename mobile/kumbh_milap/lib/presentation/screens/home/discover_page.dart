import 'package:flutter/material.dart';
import 'package:kumbh_milap/presentation/screens/components/profile_info.dart';
import 'package:provider/provider.dart';
import 'package:kumbh_milap/presentation/providers/discover_provider.dart';
import '../components/discover_header.dart';
import '../components/profile_additional_info.dart';
import '../components/profile_info_section.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => DiscoverProvider()..fetchProfiles(context),
        child: Builder(builder: (context) {
          final discoverProvider = Provider.of<DiscoverProvider>(context);

          if (discoverProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (discoverProvider.errorMessage != null) {
            return Center(child: Text(discoverProvider.errorMessage!));
          }

          final profiles = discoverProvider.profiles;
          print(profiles);

          return PageView.builder(
            itemCount: profiles.length,
            itemBuilder: (context, index) {
              final profile = profiles[index];
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DiscoverHeader(
                      profilePhoto: profile.profilePictureUrl ??
                          'https://www.piclumen.com/wp-content/uploads/2024/10/piclumen-upscale-after.webp',
                      onLikePressed: () {
                        discoverProvider.swipeRight(profile.user_id);
                      },
                      onDislikePressed: () {
                        discoverProvider.swipeLeft(profile.user_id);
                      },
                    ),
                    const SizedBox(height: 30),
                    ProfileInfo(
                      name: profile.name,
                      age: profile.age,
                      gender: profile.gender,
                      education: profile.education,
                      occupation: profile.occupation,
                      location: profile.home,
                      subGroup: profile.subgroup,
                    ),
                    const SizedBox(height: 10),
                    InterestsSection(
                      interests: profile.interests ?? [],
                      languages: profile.languages ?? [],
                    ),
                    InfoSection(
                      title: AppLocalizations.of(context)!.additionInfo,
                      information: {
                        AppLocalizations.of(context)!.lookingFor:
                            profile.lookingFor,
                        AppLocalizations.of(context)!.advice: profile.advice,
                        AppLocalizations.of(context)!.meaningOfLife:
                            profile.meaningOfLife,
                        AppLocalizations.of(context)!.achievements:
                            profile.achievements,
                        AppLocalizations.of(context)!.challenges:
                            profile.challenges,
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }));
  }
}
