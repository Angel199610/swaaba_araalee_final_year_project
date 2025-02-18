import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  "Welcome to Swaaba Aralee!\n\n"
                  "Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your personal data.\n\n"
                  "1. **Information We Collect:**\n"
                  "   - Personal details (Name, Email, Contact)\n"
                  "   - Car preferences and search history\n"
                  "   - Device and usage information\n\n"
                  "2. **How We Use Your Data:**\n"
                  "   - To improve our services\n"
                  "   - For communication and customer support\n"
                  "   - To personalize your experience\n\n"
                  "3. **Sharing Your Data:**\n"
                  "   - We do not sell your personal information\n"
                  "   - Third-party integrations (e.g., payment providers) may collect necessary data\n\n"
                  "4. **Your Rights:**\n"
                  "   - Access, update, or delete your information\n"
                  "   - Opt-out of marketing communications\n\n"
                  "By using our app, you agree to our Privacy Policy. For questions, contact support@swaabaaralee.com.",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 224, 139, 48),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
              child: Container(
                child: Text("Accept & Continue",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
