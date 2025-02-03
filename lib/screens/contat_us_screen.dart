import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './contat_us_screen.dart'; // Import your Contact Us page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactUsPage(),
    );
  }
}

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  void _launchWhatsApp() async {
    final Uri url =
        Uri.parse("https://wa.me/1234567890"); // Replace with your number
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _launchEmail() async {
    final Uri url =
        Uri.parse("mailto:support@example.com"); // Replace with your email
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _launchCall() async {
    final Uri url =
        Uri.parse("tel:+256 785220954"); // Replace with your phone number
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "WE ARE HAPPY TO HELP",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            _contactOption(
              icon: FontAwesomeIcons.whatsapp,
              title: "WhatsApp",
              subtitle: "24/7, fastest support",
              color: Colors.green.shade100,
              onTap: _launchWhatsApp,
            ),
            _contactOption(
              icon: Icons.email,
              title: "Email",
              subtitle: "Write to us",
              color: const Color.fromARGB(255, 237, 152, 23),
              onTap: _launchEmail,
            ),
            _contactOption(
              icon: Icons.phone,
              title: "Call",
              subtitle: "Speak to our agent",
              color: Colors.blueGrey.shade100,
              onTap: _launchCall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, size: 32, color: Colors.black),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Text(subtitle,
                    style:
                        const TextStyle(fontSize: 14, color: Colors.black54)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
