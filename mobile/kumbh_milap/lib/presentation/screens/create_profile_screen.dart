import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import 'package:kumbh_milap/app_theme.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _profileImage;

  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // Profile Photo Upload
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: AppTheme.lightGray,
                  backgroundImage: _profileImage != null
                      ? FileImage(File(_profileImage!.path))
                      : null,
                  child: _profileImage == null
                      ? Icon(Icons.person, size: 80, color: AppTheme.darkGray)
                      : null,
                ),
              ),

              const SizedBox(height: 40),

              // Full Name TextField
              TextField(
                onChanged: userProvider.updateName,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                  prefixIcon:
                      Icon(Icons.person_outline, color: AppTheme.darkGray),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Phone Number TextField
              TextField(
                onChanged: userProvider.updatePhoneNumber,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                  prefixIcon:
                      Icon(Icons.phone_outlined, color: AppTheme.darkGray),
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
                onChanged: userProvider.updateAge,
                decoration: InputDecoration(
                  labelText: "Age",
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                  prefixIcon:
                      Icon(Icons.phone_outlined, color: AppTheme.darkGray),
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

              // Gender Dropdown
              DropdownButtonFormField<String>(
                value:
                    userProvider.gender.isNotEmpty ? userProvider.gender : null,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    userProvider.updateGender(newValue);
                  }
                },
                decoration: InputDecoration(
                  labelText: "Gender",
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                  prefixIcon: Icon(Icons.person_outline, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
              ),

              const SizedBox(height: 20),

              // Bio TextField
              TextField(
                onChanged: userProvider.updateBio,
                decoration: InputDecoration(
                  labelText: "Bio",
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
                maxLines: 3,
              ),

              const SizedBox(height: 30),

              // Create Profile Button
              ElevatedButton(
                onPressed: () async {
                  bool success = await userProvider.createProfile();
                  if (success) {
                    // Navigate to home screen or next
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    // Show error
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: AppTheme.primaryColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                child: Text(
                  'Create Profile',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
