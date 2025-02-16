import 'package:flutter/material.dart';
import 'package:kumbh_milap/app_theme.dart';
import 'package:kumbh_milap/presentation/screens/components/profile_header.dart';
import 'package:provider/provider.dart';
import '../../providers/profile_provider.dart';
import '../components/discover_header.dart';
import '../components/error_box.dart';
import '../components/profile_info.dart';
import '../components/profile_additional_info.dart';
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
                        'https://www.piclumen.com/wp-content/uploads/2024/10/piclumen-upscale-after.webp',
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
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor),
                      onPressed: () async {
                        await profileProvider.logout();
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                      child: Text(
                        AppLocalizations.of(context)!.logout,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
