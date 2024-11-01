import 'package:flutter/material.dart';

class CheckoutPaymentScreen extends StatelessWidget {
  const CheckoutPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout & Payment")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
                decoration: InputDecoration(labelText: "Credit Card Number")),
            const TextField(decoration: InputDecoration(labelText: "Expiry Date")),
            const TextField(decoration: InputDecoration(labelText: "CVV")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: const Text("Complete Payment")),
          ],
        ),
      ),
    );
  }
}
