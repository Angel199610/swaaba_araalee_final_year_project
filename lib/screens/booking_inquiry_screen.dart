import 'package:flutter/material.dart';

class BookingInquiryScreen extends StatelessWidget {
  const BookingInquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Booking / Inquiry")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(decoration: InputDecoration(labelText: "Full Name")),
            const TextField(decoration: InputDecoration(labelText: "Phone Number")),
            const TextField(decoration: InputDecoration(labelText: "Email")),
            const TextField(decoration: InputDecoration(labelText: "Preferred Date")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: const Text("Submit Inquiry")),
          ],
        ),
      ),
    );
  }
}
