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

        Widget buildContent() {
          if (discoverProvider.isLoading) {
            return _buildLoadingOrError(child: CircularProgressIndicator());
          }

          if (discoverProvider.errorMessage != null) {
            return _buildLoadingOrError(
                child: Text(discoverProvider.errorMessage!));
          }

          final profiles = discoverProvider.profiles;

          if (profiles.isEmpty) {
            return _buildEmptyState(context);
          }

          return PageView.builder(
            itemCount: profiles.length,
            itemBuilder: (context, index) {
              final profile = profiles[index];
              return SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DiscoverHeader(
                      profilePhoto: profile.profilePictureUrl,
                      onLikePressed: () {
                        discoverProvider.swipeRight(profile.user_id);
                      },
                      onDislikePressed: () {
                        discoverProvider.swipeLeft(profile.user_id);
                      },
                      label: "Discover",
                      location: profile.home,
                      onActionButtonPressed: () {},
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
                    const SizedBox(height: 10),
                    InfoSection(information: {
                      AppLocalizations.of(context)!.bio: profile.about,
                    }),
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
        }

        return RefreshIndicator(
          onRefresh: () async {
            await discoverProvider.fetchProfiles(context);
          },
          color: Theme.of(context).scaffoldBackgroundColor,
          backgroundColor: Theme.of(context).primaryColor,
          child: buildContent(),
        );
      }),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
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
              AppLocalizations.of(context)!.noProfilesFound,
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
    );
  }

  Widget _buildLoadingOrError({required Widget child}) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        height: 500,
        child: Center(child: child),
      ),
    );
  }
}
