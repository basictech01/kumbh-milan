import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/profile_provider.dart';
import '../components/error_box.dart';
import '../components/profile_additional_info.dart';
import '../components/profile_header.dart';
import '../components/profile_info_section.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileProvider()..getProfile(),
      child: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          final profile = profileProvider.profileModel;

          if (profileProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (profileProvider.error != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showErrorDialog(context, profileProvider.error!);
            });
          }

          if (profile == null) {
            return Center(
                child: Text(AppLocalizations.of(context)!.profileNotFound));
          }

          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileHeader(
                    profilePhoto: profile.profilePictureUrl ??
                        "https://fastly.picsum.photos/id/1075/200/200.jpg?hmac=a9PcCsXBonPZ7LCLyWX6dHM1XGbcojML0qhnq-Ee4a4",
                    name: AppLocalizations.of(context)!
                        .welcomeUser(profile.name ?? "Unknown"),
                    isMatched: true,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoSection(
                          title: AppLocalizations.of(context)!.personalInfo,
                          information: {
                            AppLocalizations.of(context)!.age:
                                profile.age?.toString(),
                            AppLocalizations.of(context)!.gender:
                                profile.gender,
                            AppLocalizations.of(context)!.location:
                                profile.home,
                            AppLocalizations.of(context)!.occupation:
                                profile.occupation,
                            AppLocalizations.of(context)!.education:
                                profile.education,
                          },
                        ),
                        const SizedBox(height: 20),
                        InfoSection(
                          title: AppLocalizations.of(context)!.additionInfo,
                          information: {
                            AppLocalizations.of(context)!.lookingFor:
                                profile.lookingFor,
                            AppLocalizations.of(context)!.advice:
                                profile.advice,
                            AppLocalizations.of(context)!.meaningOfLife:
                                profile.meaningOfLife,
                            AppLocalizations.of(context)!.achievements:
                                profile.achievements,
                            AppLocalizations.of(context)!.challenges:
                                profile.challenges,
                          },
                        ),
                        const SizedBox(height: 20),
                        InterestsSection(
                          interests: profile.interests ?? [],
                          languages: profile.languages ?? [],
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              await profileProvider.logout();
                              Navigator.of(context)
                                  .pushReplacementNamed('/login');
                            },
                            child: Text(AppLocalizations.of(context)!.logout),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
