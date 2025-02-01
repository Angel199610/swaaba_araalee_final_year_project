import 'package:flutter/material.dart';

class CarCategoriesScreen extends StatelessWidget {
  const CarCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Car Categories')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Premium Cars'),
            Text('Hybrid Cars'),
            Text('Luxury cars'),
            Text('Popular family cars'),
            Text('Toyota'),
            Text('Nissan'),
            Text('Subary'),
            Text('Mercedes Benz'),
            Text('Mitsubish'),
          ],
        ),
      ),
    );
  }
}
