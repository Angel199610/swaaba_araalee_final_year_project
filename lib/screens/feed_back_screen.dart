import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  String? selectedFeedback;

  final List<String> feedbackOptions = [
    "Everything is working as expected",
    "The page is broken",
    "I couldn't create my Vista card",
    "I couldn’t complete my purchase",
    "Site looks like desktop",
    "This is not what I expected",
    "Other"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Share your feedback\nwith us",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 28),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: feedbackOptions.map((option) {
                  return RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: selectedFeedback,
                    onChanged: (value) {
                      setState(() {
                        selectedFeedback = value;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: selectedFeedback == null ? null : () {
                // Handle feedback submission
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Feedback submitted!")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedFeedback == null ? Colors.white : Colors.orange,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Send feedback"),
            ),
          ],
        ),
      ),
    );
  }
}
