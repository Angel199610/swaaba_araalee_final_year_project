import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool notificationsEnabled = true; // Default notification status

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Notifications
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Notifications"),
            trailing: StatefulBuilder(
              builder: (BuildContext context, setState) {
                return Switch(
                  value: notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      notificationsEnabled = value;
                    });
                  },
                );
              },
            ),
          ),
          const Divider(),

          // Language
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Language"),
            onTap: () {
              // Navigate to language selection screen or show a dialog
              _showLanguageDialog(context);
            },
          ),
          const Divider(),

          // Privacy Policy & Terms of Use
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text("Privacy Policy & Terms of Use"),
            onTap: () {
              // Navigate to Privacy Policy & Terms screen
            },
          ),
          const Divider(),

          // Help and Feedback
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text("Help and Feedback"),
            onTap: () {
              // Navigate to Help and Feedback screen
            },
          ),
          const Divider(),

          // Rate Us
          ListTile(
            leading: const Icon(Icons.star_rate),
            title: const Text("Rate Us"),
            onTap: () {
              // Handle rate us functionality
            },
          ),
          const Divider(),

          // Share this App
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text("Share This App"),
            onTap: () {
              // Share the app using share functionality
            },
          ),
          const Divider(),

          // Delete Account
          ListTile(
            leading: const Icon(Icons.delete_forever),
            title: const Text("Delete Account"),
            onTap: () {
              // Show confirmation dialog before deleting account
              _showDeleteAccountDialog(context);
            },
          ),
          const Divider(),

          // Logout
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              // Handle logout functionality
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Language"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("English"),
                onTap: () {
                  // Handle language selection
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("French"),
                onTap: () {
                  // Handle language selection
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Spanish"),
                onTap: () {
                  // Handle language selection
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Account"),
          content: const Text(
              "Are you sure you want to delete your account? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle account deletion
                Navigator.pop(context);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
