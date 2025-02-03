import 'package:flutter/material.dart';
import 'package:swaaba_aralee/screens/contat_us_screen.dart';
import './policies_screen.dart';
import 'feed_back_screen.dart';
import './share_screen.dart';
import './rate_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool notificationsEnabled = true; // Default notification status
    String userName = "Nanteza Angellah"; // Example user name
    String avatarUrl = "https://via.placeholder.com/150"; // Example avatar URL

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange, // Set background color to orange
        title: Row(
          children: [
            // User Avatar
            CircleAvatar(
              backgroundImage: NetworkImage(avatarUrl),
            ),
            const SizedBox(width: 10), // Space between avatar and name
            // User Name
            Text(
              userName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white, // White text for contrast
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildCard(
                    context,
                    icon: Icons.notifications,
                    title: "Notifications",
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
                  const SizedBox(height: 10), // Space between items
                  _buildCard(
                    context,
                    icon: Icons.language,
                    title: "Language",
                    onTap: () => _showLanguageDialog(context),
                  ),
                  const SizedBox(height: 10),
                  _buildCard(
                    context,
                    icon: Icons.privacy_tip,
                    title: "Privacy Policy & Terms of Use",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivacyPolicyScreen()));
                    },
                  ),

                  const SizedBox(height: 10),
                  _buildCard(
                    context,
                    icon: Icons.help_outline,
                    title: "Help and Feedback",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FeedbackScreen()));
                    },
                  ),
                  const SizedBox(height: 10),
                  // Contact Us card (moved here)
                  _buildCard(
                    context,
                    icon: Icons.contact_mail,
                    title: "Contact Us",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ContactUsPage()));
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildCard(
                    context,
                    icon: Icons.star_rate,
                    title: "Rate Us",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RateUsPage()));
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildCard(
                    context,
                    icon: Icons.share,
                    title: "Share This App",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShareAppScreen()));
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildCard(
                    context,
                    icon: Icons.delete_forever,
                    title: "Delete Account",
                    onTap: () => _showDeleteAccountDialog(context),
                  ),
                  const SizedBox(height: 10),
                  _buildCard(
                    context,
                    icon: Icons.logout,
                    title: "Logout",
                    centered: true,
                    onTap: () {},
                  ),

                  const SizedBox(height: 30), // Space before logo

                  // Swaaba Araale Logo, Title, and Version
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Image.asset(
                          'lib/assets/logo.png', // Ensure you have a logo in assets
                          height: 50,
                        ),
                        const SizedBox(
                            height: 10), // Space between logo and text
                        const Text(
                          "Swaaba Araale",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Version 7.9.5",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required IconData icon,
      required String title,
      Widget? trailing,
      VoidCallback? onTap,
      bool centered = false}) {
    return Card(
      elevation: 3, // Slight shadow
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange), // Orange icon
        title: Text(
          title,
          textAlign: centered ? TextAlign.center : TextAlign.start,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: trailing,
        onTap: onTap,
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
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("French"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Spanish"),
                onTap: () {
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
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
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


















// import 'package:flutter/material.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     bool notificationsEnabled = true; // Default notification status
//     String userName = "Nanteza Angellah"; // Example user name
//     String avatarUrl = "https://via.placeholder.com/150"; // Example avatar URL

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.orange, // Set background color to orange
//         title: Row(
//           children: [
//             // User Avatar
//             CircleAvatar(
//               backgroundImage: NetworkImage(avatarUrl),
//             ),
//             const SizedBox(width: 10), // Space between avatar and name
//             // User Name
//             Text(
//               userName,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white, // White text for contrast
//               ),
//             ),
//             // const Spacer(), // Push notification icon to the right
//             // // Notifications Icon
//             // IconButton(
//             //   icon: const Icon(Icons.notifications, color: Colors.white),
//             //   onPressed: () {
//             //     // Handle notification tap
//             //   },
//             // ),
//           ],
//         ),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           // Notifications
//           ListTile(
//             leading: const Icon(Icons.notifications),
//             title: const Text("Notifications"),
//             trailing: StatefulBuilder(
//               builder: (BuildContext context, setState) {
//                 return Switch(
//                   value: notificationsEnabled,
//                   onChanged: (value) {
//                     setState(() {
//                       notificationsEnabled = value;
//                     });
//                   },
//                 );
//               },
//             ),
//           ),
//           const Divider(),

//           // Language
//           ListTile(
//             leading: const Icon(Icons.language),
//             title: const Text("Language"),
//             onTap: () {
//               _showLanguageDialog(context);
//             },
//           ),
//           const Divider(),

//           // Privacy Policy & Terms of Use
//           ListTile(
//             leading: const Icon(Icons.privacy_tip),
//             title: const Text("Privacy Policy & Terms of Use"),
//             onTap: () {},
//           ),
//           const Divider(),

//           // Help and Feedback
//           ListTile(
//             leading: const Icon(Icons.help_outline),
//             title: const Text("Help and Feedback"),
//             onTap: () {},
//           ),
//           const Divider(),

//           // Rate Us
//           ListTile(
//             leading: const Icon(Icons.star_rate),
//             title: const Text("Rate Us"),
//             onTap: () {},
//           ),
//           const Divider(),

//           // Share this App
//           ListTile(
//             leading: const Icon(Icons.share),
//             title: const Text("Share This App"),
//             onTap: () {},
//           ),
//           const Divider(),

//           // Delete Account
//           ListTile(
//             leading: const Icon(Icons.delete_forever),
//             title: const Text("Delete Account"),
//             onTap: () {
//               _showDeleteAccountDialog(context);
//             },
//           ),
//           const Divider(),

//           // Logout
//           Align(
//             alignment: Alignment.center,
//             child: ListTile(
//                // Orange icon with larger size
//               title: Text(
//                 "Logout",
//                 textAlign: TextAlign.center, // Centers the text
//                 style: TextStyle(fontWeight: FontWeight.bold), // Bold text
//               ),
//               onTap: () {},
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showLanguageDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Select Language"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 title: const Text("English"),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 title: const Text("French"),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 title: const Text("Spanish"),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _showDeleteAccountDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Delete Account"),
//           content: const Text(
//               "Are you sure you want to delete your account? This action cannot be undone."),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text("Delete"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
