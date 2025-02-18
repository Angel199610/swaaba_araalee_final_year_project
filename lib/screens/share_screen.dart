import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShareAppScreen extends StatelessWidget {
  final String shareMessage =
      "Check out this amazing app! Download it now: https://yourapp.link";

  const ShareAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Share This App"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Invite your friends to experience this amazing app!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),

            // Share Options (Buttons)
            Wrap(
              spacing: 15,
              children: [
                _buildShareButton(
                    "WhatsApp", FontAwesomeIcons.whatsapp, Colors.green, () {
                  Share.share(shareMessage);
                }),
                _buildShareButton("Facebook", Icons.facebook, Colors.blue, () {
                  Share.share(shareMessage);
                }),
                _buildShareButton("Twitter", Icons.share, Colors.lightBlue, () {
                  Share.share(shareMessage);
                }),
                _buildShareButton("Instagram", Icons.camera_alt, Colors.purple,
                    () {
                  Share.share(shareMessage);
                }),
                _buildShareButton("Email", Icons.email, Colors.red, () {
                  Share.share(shareMessage);
                }),
                _buildShareButton("Copy Link", Icons.link, Colors.black, () {
                  Share.share(shareMessage);
                }),
              ],
            ),

            SizedBox(height: 30),

            // Main Share Button
            ElevatedButton(
              onPressed: () {
                Share.share(shareMessage);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Share Now",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareButton(
      String label, IconData icon, Color color, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
