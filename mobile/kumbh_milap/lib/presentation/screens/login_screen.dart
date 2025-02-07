import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:kumbh_milap/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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

              // Email TextField
              TextField(
                onChanged: authProvider.updateUsername,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.usernameLabel,
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                  prefixIcon:
                      Icon(Icons.person_2_outlined, color: AppTheme.darkGray),
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
                  labelText: AppLocalizations.of(context)!.passwordLabel,
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
              authProvider.isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        bool success = await authProvider.login(
                          authProvider.username,
                          authProvider.password,
                        );
                        if (success) {
                          // Navigate to home screen or next
                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          // Show error
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                authProvider.errorMessage.toString(),
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        backgroundColor: AppTheme.primaryColor,
                        padding: EdgeInsets.all(18),
                      ),
                      child: Icon(Icons.arrow_forward,
                          size: 28, color: AppTheme.white),
                    ),

              SizedBox(height: 20),

              // Signup Navigation Text
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text(
                  AppLocalizations.of(context)!.noAccountText,
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
