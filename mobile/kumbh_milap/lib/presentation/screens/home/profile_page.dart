import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/profile_provider.dart';
import '../components/profile_additional_info.dart';
import '../components/profile_header.dart';
import '../components/profile_info_section.dart';

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
            return Center(child: Text(profileProvider.error!));
          }

          if (profile == null) {
            return Center(child: Text('Profile not found'));
          }

          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileHeader(
                    profilePhoto:
                        profile.profilePictureUrl ?? '/placeholder.jpg',
                    name: profile.name ?? 'Unknown',
                    isMatched: true,
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
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              await profileProvider.logout();
                              Navigator.of(context)
                                  .pushReplacementNamed('/login');
                            },
                            child: Text('Logout'),
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
