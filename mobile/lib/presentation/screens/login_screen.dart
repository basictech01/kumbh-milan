import 'package:flutter/material.dart';
import 'package:kumbh_milap/presentation/screens/components/error_box.dart';
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
                  color: Theme.of(context).scaffoldBackgroundColor,
                  shape: BoxShape.rectangle,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/sadhu.png',
                    width: 240,
                    height: 240,
                  ),
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
                  : SizedBox(
                      width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          bool connected =
                              await authProvider.checkInternetConnection(context);
                          if (!connected) {
                            showErrorDialog(context,
                                AppLocalizations.of(context)!.networkError);
                            return;
                          }
                          bool success = await authProvider.login(
                            authProvider.username,
                            authProvider.password,
                            context,
                          );
                          if (success) {
                            // Navigate to home screen or next
                            Navigator.pushReplacementNamed(context, '/home');
                          } else {
                            showErrorDialog(
                                context, authProvider.errorMessage.toString());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            minimumSize: const Size(150, 45)),
                        child: Text(
                          AppLocalizations.of(context)!.login,
                          style: TextStyle(color: Colors.white),
                        )),
                  ),

              SizedBox(height: 20),

              // Signup Navigation Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      minimumSize: const Size(150, 45)),
                  child: Text(
                    AppLocalizations.of(context)!.noAccountText,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppTheme.white,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to terms and conditions page
                      Navigator.pushNamed(context, '/termsConditions');
                    },
                    child: Text(
                      AppLocalizations.of(context)!.termsAndConditions,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
