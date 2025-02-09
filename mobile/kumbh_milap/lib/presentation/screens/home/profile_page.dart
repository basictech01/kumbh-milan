import 'package:flutter/material.dart';

import '../components/profile_additional_info.dart';
import '../components/profile_button.dart';
import '../components/profile_header.dart';
import '../components/profile_info_section.dart';

class ProfilePage extends StatelessWidget {
  final String username;
  final String name;
  final String? profilePhoto;
  final String? bio;
  final Map<String, String?> personalInfo;
  final Map<String, String?> additionalInfo;
  final List<String> interests;
  final List<String> languages;
  final VoidCallback onUpdateProfile;

  const ProfilePage({
    super.key,
    required this.username,
    this.profilePhoto,
    this.bio,
    required this.name,
    required this.personalInfo,
    required this.additionalInfo,
    required this.interests,
    required this.languages,
    required this.onUpdateProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(
              username: username,
              profilePhoto: profilePhoto,
              name: name,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoSection(
                    title: 'Personal Information',
                    information: personalInfo,
                  ),
                  const SizedBox(height: 20),
                  InfoSection(
                    title: 'Additional Information',
                    information: additionalInfo,
                  ),
                  const SizedBox(height: 20),
                  InterestsSection(
                    interests: interests,
                    languages: languages,
                  ),
                  const SizedBox(height: 30),
                  ProfileButton(
                    onPressed: onUpdateProfile,
                    label: 'Update Profile',
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
