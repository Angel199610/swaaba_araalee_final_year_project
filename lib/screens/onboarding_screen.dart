import 'package:flutter/material.dart';
import '../screens/signup_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          buildOnboardingPage(
              context,
              'Quality Imports',
              'We offer the best imports.',
              const Color.fromARGB(255, 240, 124, 16)),
          buildOnboardingPage(context, 'Affordable Used Cars',
              'Reliable used cars at great prices.', Colors.green),
          buildOnboardingPage(context, 'New Arrivals',
              'Browse the latest models.', Colors.orange),
        ],
      ),
    );
  }

  Widget buildOnboardingPage(
      BuildContext context, String title, String description, Color color) {
    return Container(
      color: color,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(fontSize: 24, color: Colors.white)),
            Text(description,
                style: const TextStyle(fontSize: 16, color: Colors.white)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
