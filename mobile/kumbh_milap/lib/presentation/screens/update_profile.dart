import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import 'package:kumbh_milap/app_theme.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class UpdateProfileScreen extends StatefulWidget {
  final ProfileProvider userProvider;
  const UpdateProfileScreen({super.key, required this.userProvider});

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
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
  void initState() {
    super.initState();
    widget.userProvider.fillProfileFromSharedPref();
  }

  @override
  Widget build(BuildContext context) {
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
                    await widget.userProvider.pickAndUploadProfilePhoto();
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: widget.userProvider.profilePhoto != null
                        ? NetworkImage(widget.userProvider.profilePhoto!)
                        : null,
                  ),
                ),

                const SizedBox(height: 40),

                TextField(
                  controller: TextEditingController(
                      text: widget.userProvider.age?.toString()),
                  onChanged: widget.userProvider.updateAge,
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
                  controller:
                      TextEditingController(text: widget.userProvider.home),
                  onChanged: widget.userProvider.updateHome,
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
                    ["MALE", AppLocalizations.of(context)!.genderMale],
                    ["FEMALE", AppLocalizations.of(context)!.genderFemale],
                    ["OTHER", AppLocalizations.of(context)!.genderOther]
                  ].map((gender) {
                    return ChoiceChip(
                      label: Text(gender[1]),
                      selected: widget.userProvider.gender == gender[0],
                      onSelected: (bool selected) {
                        if (selected) {
                          widget.userProvider.updateGender(gender[0]);
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      selectedColor: Theme.of(context).primaryColor,
                      backgroundColor: Colors.grey[100],
                      labelStyle: TextStyle(
                        color: widget.userProvider.gender == gender[0]
                            ? Colors.white
                            : Colors.black,
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                // Education TextField
                TextField(
                  controller: TextEditingController(
                      text: widget.userProvider.education),
                  onChanged: widget.userProvider.updateEducation,
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
                  controller: TextEditingController(
                      text: widget.userProvider.occupation),
                  onChanged: widget.userProvider.updateOccupation,
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
                  controller:
                      TextEditingController(text: widget.userProvider.subgroup),
                  onChanged: widget.userProvider.updateSubgroup,
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
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        minimumSize: const Size(150, 45)),
                    child: Text(
                      AppLocalizations.of(context)!.next,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: AppTheme.white,
                          ),
                    )),
              ] else if (additionalFields == 1) ...[
                SingleChildScrollView(
                  child: TextField(
                    controller: TextEditingController(
                        text: widget.userProvider.lookingFor),
                    onChanged: widget.userProvider.updateLookingFor,
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
                    controller:
                        TextEditingController(text: widget.userProvider.bio),
                    onChanged: widget.userProvider.updateBio,
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
                  AppLocalizations.of(context)!.prefLanguage,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Wrap(
                  spacing: 8.0,
                  children: allLanguages.map((language) {
                    final isSelected =
                        widget.userProvider.languages.contains(language);
                    return ChoiceChip(
                      label: Text(language),
                      selected: isSelected,
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            widget.userProvider.addLanguage(language);
                          } else {
                            widget.userProvider.removeLanguage(language);
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
                  AppLocalizations.of(context)!.interests,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Wrap(
                  spacing: 8.0,
                  children: allInterest.map((interest) {
                    final isSelected =
                        widget.userProvider.interests.contains(interest);
                    return ChoiceChip(
                      label: Text(interest),
                      selected: isSelected,
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            widget.userProvider.addInterest(interest);
                          } else {
                            widget.userProvider.removeInterest(interest);
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
                    controller:
                        TextEditingController(text: widget.userProvider.advice),
                    onChanged: widget.userProvider.updateAdvice,
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
                    controller: TextEditingController(
                        text: widget.userProvider.meaningOfLife),
                    onChanged: widget.userProvider.updateMeaningOfLife,
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
                    controller: TextEditingController(
                        text: widget.userProvider.achievements),
                    onChanged: widget.userProvider.updateAchievements,
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
                    controller: TextEditingController(
                        text: widget.userProvider.challenges),
                    onChanged: widget.userProvider.updateChallenges,
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
                          await widget.userProvider.createOrUpdateProfile();

                          if (widget.userProvider.error == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(AppLocalizations.of(context)!
                                      .profileSuccess)),
                            );
                            Navigator.pushReplacementNamed(context, '/home');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(widget.userProvider.error!)),
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
                          AppLocalizations.of(context)!.submit,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
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
