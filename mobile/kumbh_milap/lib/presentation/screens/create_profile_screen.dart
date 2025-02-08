import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/profile_provider.dart';
import 'package:kumbh_milap/app_theme.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  int additionalFields = 0;
  final List<String> allLanguages = [
    'English',
    'Hindi',
    'Gujarati',
    'Marathi',
    'Punjabi'
  ];
  List<String> allInterest = [
    'Reading',
    'Writing',
    'Travelling',
    'Cooking',
    'Dancing',
    'Singing',
    'Painting',
    'Sports',
    'Gaming',
    'Photography',
  ];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              if (additionalFields == 0) ...[
                // Profile Photo Upload
                GestureDetector(
                  onTap: () async {
                    await userProvider.pickAndUploadProfilePhoto();
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: userProvider.profilePhoto != null
                        ? NetworkImage(userProvider.profilePhoto!)
                        : null,
                  ),
                ),

                const SizedBox(height: 40),

                // Display Full Name
                // TextField(
                //   onChanged: userProvider.updateName,
                //   decoration: InputDecoration(
                //     labelText: AppLocalizations.of(context)!.fullname,
                //     labelStyle: Theme.of(context).textTheme.bodyLarge,
                //     prefixIcon: Icon(Icons.person, color: AppTheme.darkGray),
                //     filled: true,
                //     fillColor: Colors.grey[100],
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(12),
                //       borderSide: BorderSide.none,
                //     ),
                //   ),
                //   keyboardType: TextInputType.phone,
                // ),

                // const SizedBox(height: 20),

                TextField(
                  onChanged: userProvider.updateAge,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.age,
                    labelStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcon: Icon(Icons.numbers, color: AppTheme.darkGray),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 20),

                TextField(
                  onChanged: userProvider.updateHome,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.home,
                    labelStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcon:
                        Icon(Icons.home_filled, color: AppTheme.darkGray),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),

                const SizedBox(height: 20),

                // Gender Dropdown
                Wrap(
                  spacing: 8.0,
                  children: [
                    AppLocalizations.of(context)!.genderMale,
                    AppLocalizations.of(context)!.genderFemale,
                    AppLocalizations.of(context)!.genderOther
                  ].map((gender) {
                    return ChoiceChip(
                      label: Text(gender),
                      selected: userProvider.gender == gender,
                      onSelected: (bool selected) {
                        if (selected) {
                          userProvider.updateGender(gender);
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      selectedColor: Theme.of(context).primaryColor,
                      backgroundColor: Colors.grey[100],
                      labelStyle: TextStyle(
                        color: userProvider.gender == gender
                            ? Colors.white
                            : Colors.black,
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                // Education TextField
                TextField(
                  onChanged: userProvider.updateEducation,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.education,
                    labelStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcon: Icon(Icons.school, color: AppTheme.darkGray),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  onChanged: userProvider.updateOccupation,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.occupation,
                    labelStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcon: Icon(Icons.work, color: AppTheme.darkGray),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: userProvider.updateSubgroup,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.subGroup,
                    labelStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcon: Icon(Icons.group, color: AppTheme.darkGray),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // More info Button
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        additionalFields++;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: AppTheme.primaryColor,
                      padding: EdgeInsets.all(18),
                    ),
                    child: Icon(Icons.arrow_forward,
                        size: 28, color: AppTheme.white)),
              ] else if (additionalFields == 1) ...[
                SingleChildScrollView(
                  child: TextField(
                    onChanged: userProvider.updateLookingFor,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.lookingFor,
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                      prefixIcon: Icon(Icons.search, color: AppTheme.darkGray),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    maxLength: 1000,
                    maxLines: 2, // Adjust this value as needed
                  ),
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  child: TextField(
                    onChanged: userProvider.updateBio,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.bio,
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                      prefixIcon:
                          Icon(Icons.info_outline, color: AppTheme.darkGray),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    maxLength: 1000,
                    maxLines: 2, // Adjust this value as needed
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Preferred Language:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Wrap(
                  spacing: 8.0,
                  children: allLanguages.map((language) {
                    final isSelected =
                        userProvider.languages.contains(language);
                    return ChoiceChip(
                      label: Text(language),
                      selected: isSelected,
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            userProvider.addLanguage(language);
                          } else {
                            userProvider.removeLanguage(language);
                          }
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      selectedColor: Theme.of(context).primaryColor,
                      backgroundColor: Colors.grey[100],
                      labelStyle: TextStyle(
                        color: (isSelected) ? Colors.white : Colors.black,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Text(
                  'Interests:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Wrap(
                  spacing: 8.0,
                  children: allInterest.map((interest) {
                    final isSelected =
                        userProvider.interests.contains(interest);
                    return ChoiceChip(
                      label: Text(interest),
                      selected: isSelected,
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            userProvider.addInterest(interest);
                          } else {
                            userProvider.removeInterest(interest);
                          }
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      selectedColor: Theme.of(context).primaryColor,
                      backgroundColor: Colors.grey[100],
                      labelStyle: TextStyle(
                        color: (isSelected) ? Colors.white : Colors.black,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            additionalFields--;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          backgroundColor: AppTheme.primaryColor,
                          padding: EdgeInsets.all(18),
                        ),
                        child: Icon(Icons.arrow_back,
                            size: 28, color: AppTheme.white)),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            additionalFields++;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          backgroundColor: AppTheme.primaryColor,
                          padding: EdgeInsets.all(18),
                        ),
                        child: Icon(Icons.arrow_forward,
                            size: 28, color: AppTheme.white)),
                  ],
                )
              ] else ...[
                SingleChildScrollView(
                  child: TextField(
                    onChanged: userProvider.updateAdvice,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.advice,
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                      prefixIcon:
                          Icon(Icons.info_outline, color: AppTheme.darkGray),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    maxLength: 1000,
                    maxLines: 3, // Adjust this value as needed
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  child: TextField(
                    onChanged: userProvider.updateMeaningOfLife,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.meaningOfLife,
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                      prefixIcon:
                          Icon(Icons.info_outline, color: AppTheme.darkGray),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    maxLength: 1000,
                    maxLines: 3, // Adjust this value as needed
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  child: TextField(
                    onChanged: userProvider.updateAchievements,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.achievements,
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                      prefixIcon:
                          Icon(Icons.info_outline, color: AppTheme.darkGray),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    maxLength: 1000,
                    maxLines: 3, // Adjust this value as needed
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  child: TextField(
                    onChanged: userProvider.updateChallenges,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.challenges,
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                      prefixIcon:
                          Icon(Icons.info_outline, color: AppTheme.darkGray),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    maxLength: 1000,
                    maxLines: 3, // Adjust this value as needed
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            additionalFields--;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          backgroundColor: AppTheme.primaryColor,
                          padding: EdgeInsets.all(18),
                        ),
                        child: Icon(Icons.arrow_back,
                            size: 28, color: AppTheme.white)),
                    ElevatedButton(
                        onPressed: () async {
                          await userProvider.createProfile();

                          if (userProvider.error == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Profile Created Successfully")),
                            );
                            Navigator.pushReplacementNamed(context, '/home');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(userProvider.error!)),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: AppTheme.primaryColor,
                          padding: EdgeInsets.all(18),
                        ),
                        child: Text(
                          "Submit",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: AppTheme.white),
                        )),
                  ],
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
