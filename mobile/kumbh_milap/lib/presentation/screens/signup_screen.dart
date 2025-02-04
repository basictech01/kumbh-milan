import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:kumbh_milap/app_theme.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),

              // Clipart Placeholder
              Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  color: AppTheme.lightGray,
                  shape: BoxShape.rectangle,
                ),
                child: Center(
                  child: Icon(Icons.person, size: 80, color: AppTheme.darkGray),
                ),
              ),

              SizedBox(height: 40),

              //username
              TextField(
                onChanged: authProvider.updateUsername,
                decoration: InputDecoration(
                  labelText: "Username",
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                  prefixIcon:
                      Icon(Icons.person_4_outlined, color: AppTheme.darkGray),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              // Email TextField
              TextField(
                onChanged: authProvider.updateEmail,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                  prefixIcon:
                      Icon(Icons.email_outlined, color: AppTheme.darkGray),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(height: 20),

              // Password TextField
              TextField(
                onChanged: authProvider.updatePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                  prefixIcon:
                      Icon(Icons.lock_outline, color: AppTheme.darkGray),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: true,
              ),

              SizedBox(height: 30),

              TextField(
                onChanged: authProvider.updateConfirmPassword,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                  prefixIcon:
                      Icon(Icons.lock_outline, color: AppTheme.darkGray),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: true,
              ),

              SizedBox(height: 30),

              // Login Button
              ElevatedButton(
                onPressed: () async {
                  bool success = await authProvider.signUp();
                  if (success) {
                    // Navigate to home screen or next
                    Navigator.pushReplacementNamed(context, '/createProfile');
                  } else {
                    // Show error
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: AppTheme.primaryColor,
                  padding: EdgeInsets.all(18),
                ),
                child:
                    Icon(Icons.arrow_forward, size: 28, color: AppTheme.white),
              ),

              SizedBox(height: 20),

              // Signup Navigation Text
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Have an account? Log in",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.secondaryColor,
                        decoration: TextDecoration.underline,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
