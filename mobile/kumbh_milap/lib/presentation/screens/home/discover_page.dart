import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kumbh_milap/presentation/providers/discover_provider.dart';
import '../components/profile_additional_info.dart';
import '../components/profile_button.dart';
import '../components/profile_header.dart';
import '../components/profile_info_section.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DiscoverProvider>(context, listen: false).fetchProfiles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DiscoverProvider>(
        builder: (context, discoverProvider, child) {
          if (discoverProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (discoverProvider.errorMessage != null) {
            return Center(child: Text(discoverProvider.errorMessage!));
          }

          final profiles = discoverProvider.profiles;

          return PageView.builder(
            itemCount: profiles.length,
            itemBuilder: (context, index) {
              final profile = profiles[index];
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileHeader(
                        profilePhoto: profile.profilePictureUrl ??
                            'https://pixabay.com/vectors/blank-profile-picture-mystery-man-973460/',
                        name: profile.name ?? 'Unknown',
                        isMatched: false,
                      ),
                      const SizedBox(height: 20),
                      InfoSection(
                        title: 'Personal Information',
                        information: {
                          'Age': profile.age?.toString(),
                          'Gender': profile.gender,
                          'Location': profile.home,
                          'Occupation': profile.occupation,
                          'Education': profile.education,
                        },
                      ),
                      const SizedBox(height: 20),
                      InfoSection(
                        title: 'Additional Information',
                        information: {
                          'Looking For': profile.lookingFor,
                          'Advice': profile.advice,
                          'Meaning of Life': profile.meaningOfLife,
                          'Achievements': profile.achievements,
                          'Challenges': profile.challenges,
                        },
                      ),
                      const SizedBox(height: 20),
                      InterestsSection(
                        interests: profile.interests ?? [],
                        languages: profile.languages ?? [],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ProfileButton(
                            onPressed: () {
                              discoverProvider
                                  .swipeLeft(profile.user_id! as String);
                            },
                            label: 'Swipe Left',
                          ),
                          ProfileButton(
                            onPressed: () {
                              discoverProvider
                                  .swipeRight(profile.user_id! as String);
                            },
                            label: 'Swipe Right',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
