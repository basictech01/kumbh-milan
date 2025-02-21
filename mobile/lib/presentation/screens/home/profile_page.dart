import 'package:flutter/material.dart';
import 'package:kumbh_milap/presentation/screens/components/profile_header.dart';
import 'package:provider/provider.dart';
import '../../../app_theme.dart';
import '../../providers/profile_provider.dart';
import '../components/error_box.dart';
import '../components/profile_info.dart';
import '../components/profile_additional_info.dart';
import '../components/profile_info_section.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    if (profileProvider.isLoading) {
      return _buildLoadingOrError(
        child: CircularProgressIndicator(),
      );
    }

    if (profileProvider.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showErrorDialog(context, profileProvider.error!);
      });
    }

    if (profileProvider.profileModel == null) {
      return _buildEmptyState(context);
    }

    final profile = profileProvider.profileModel!;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await profileProvider.getProfile();
        },
        color: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileHeader(
                profilePhoto: profile.profilePictureUrl,
                location: profile.home,
              ),
              const SizedBox(height: 30),
              ProfileInfo(
                name: profile.name,
                age: profile.age,
                gender: profile.gender,
                education: profile.education,
                occupation: profile.occupation,
                subGroup: profile.subgroup,
              ),
              const SizedBox(height: 10),
              InterestsSection(
                interests: profile.interests ?? [],
                languages: profile.languages ?? [],
              ),
              InfoSection(information: {
                AppLocalizations.of(context)!.bio: profile.about,
              }),
              const SizedBox(height: 20),
              InfoSection(
                title: AppLocalizations.of(context)!.additionInfo,
                information: {
                  AppLocalizations.of(context)!.lookingFor: profile.lookingFor,
                  AppLocalizations.of(context)!.advice: profile.advice,
                  AppLocalizations.of(context)!.meaningOfLife:
                      profile.meaningOfLife,
                  AppLocalizations.of(context)!.achievements:
                      profile.achievements,
                  AppLocalizations.of(context)!.challenges: profile.challenges,
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        minimumSize: const Size(150, 45)),
                    onPressed: () async {
                      await profileProvider.logout();
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    child: Text(
                      AppLocalizations.of(context)!.logout,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        minimumSize: const Size(150, 45)),
                    onPressed: () async {
                      //pass provider to updateProfile screen
                      await profileProvider.fillProfileFromSharedPref();
                      Navigator.of(context).pushNamed('/updateProfile');
                    },
                    child: Text(
                      AppLocalizations.of(context)!.editProfile,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  // Navigate to terms and conditions page
                  Navigator.pushNamed(context, '/termsConditions');
                },
                child: Text(
                  AppLocalizations.of(context)!.termsAndConditions,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingOrError({required Widget child}) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            height: 500,
            child: Center(child: child),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/sadhu.png',
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.profileNotFound,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.pullToRefresh,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
