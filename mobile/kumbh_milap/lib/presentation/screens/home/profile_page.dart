import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/profile_provider.dart';
import '../components/profile_additional_info.dart';
import '../components/profile_button.dart';
import '../components/profile_header.dart';
import '../components/profile_info_section.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          final profile = profileProvider.profileModel;

          if (profile == null) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                ProfileHeader(
                  profilePhoto: profile.profilePictureUrl ?? '/placeholder.jpg',
                  name: profile.name ?? 'Unknown',
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      ProfileButton(
                        onPressed: () {
                          // Handle profile update
                        },
                        label: 'Update Profile',
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
