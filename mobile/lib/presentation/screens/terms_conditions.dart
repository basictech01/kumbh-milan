import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.termsAndConditions,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        //change the back button color
        iconTheme:
            IconThemeData(color: Theme.of(context).scaffoldBackgroundColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              _buildSectionTitle('1. Acceptance of Terms'),
              _buildSectionContent(
                  'By using the App, you agree to these Terms, as well as our Privacy Policy. If you do not agree to these Terms, do not use the App.'),
              SizedBox(height: 20),
              _buildSectionTitle('2. Eligibility'),
              _buildSectionContent(
                  'You must be at least 18 years of age or the legal age of majority in your jurisdiction to use the App. By agreeing to these Terms, you confirm that you meet the age requirement.'),
              SizedBox(height: 20),
              _buildSectionTitle('3. Account Registration and Information'),
              _buildSectionContent(
                  'To use the App, you must create an account by providing accurate and truthful personal information, including but not limited to your name, email address, and phone number. You are responsible for maintaining the confidentiality of your account and password.'),
              SizedBox(height: 20),
              _buildSectionTitle('4. Matching and Communication'),
              _buildSectionContent(
                  'The App is designed to allow users to find and connect with other people based on shared interests. Once a match is made between you and another user, you may communicate with them via text or voice call. By using the communication features of the App, you acknowledge and consent to our monitoring and storage of messages and calls, subject to our Privacy Policy.'),
              SizedBox(height: 20),
              _buildSectionTitle('5. Use of Services'),
              _buildSectionContent(
                  'You agree to use the App for lawful purposes only. You shall not use the App to:\n- Violate any laws or regulations.\n- Harass, abuse, or harm other users.\n- Impersonate any person or entity, or mislead others about your identity.\n- Engage in any conduct that could damage, disable, or overburden the App or interfere with other users\' enjoyment.'),
              SizedBox(height: 20),
              _buildSectionTitle('6. Privacy and Data Protection'),
              _buildSectionContent(
                  'We take your privacy seriously. Our Privacy Policy outlines the types of personal information we collect, how it is used, and the steps we take to protect it. By using the App, you consent to the collection and processing of your personal data as described in the Privacy Policy.'),
              SizedBox(height: 20),
              _buildSectionTitle('7. Prohibited Content'),
              _buildSectionContent(
                  'You may not upload, post, or transmit any content that is unlawful, defamatory, harmful, abusive, offensive, or otherwise objectionable. We reserve the right to remove any content that violates these Terms.'),
              SizedBox(height: 20),
              _buildSectionTitle('8. Termination'),
              _buildSectionContent(
                  'We reserve the right to suspend or terminate your account at our discretion if we believe you have violated these Terms. You may also deactivate your account at any time by following the instructions in the App.'),
              SizedBox(height: 20),
              _buildSectionTitle('9. Disclaimers'),
              _buildSectionContent(
                  'The App is provided on an "as-is" and "as-available" basis, without any warranties of any kind, either express or implied. We do not guarantee the accuracy, completeness, or reliability of any information or matches made through the App.'),
              SizedBox(height: 20),
              _buildSectionTitle('10. Limitation of Liability'),
              _buildSectionContent(
                  'To the fullest extent permitted by law, we are not liable for any damages arising from your use of the App, including but not limited to direct, indirect, incidental, punitive, or consequential damages. This includes any damages resulting from interactions with other users or the misuse of your personal information.'),
              SizedBox(height: 20),
              _buildSectionTitle('11. Governing Law'),
              _buildSectionContent(
                  'These Terms are governed by and construed in accordance with the laws of [Your Jurisdiction]. Any disputes arising from or related to these Terms shall be resolved exclusively in the courts of [Your Jurisdiction].'),
              SizedBox(height: 20),
              _buildSectionTitle('12. Changes to Terms'),
              _buildSectionContent(
                  'We reserve the right to modify, amend, or update these Terms at any time. Any changes will be effective immediately upon posting in the App or on our website. We encourage you to review these Terms periodically.'),
              SizedBox(height: 20),
              _buildSectionTitle('13. Contact Us'),
              _buildSectionContent(
                  'If you have any questions about these Terms, please contact us at:\n[pranavpandey1998developer@gmail.com]'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
  Widget _buildSectionContent(String content) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 16,
        height: 1.5,
      ),
    );
  }
}
