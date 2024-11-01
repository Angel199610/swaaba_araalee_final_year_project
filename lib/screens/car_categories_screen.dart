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
            Text('Imported Cars'),
            Text('Used Cars'),
            Text('New Cars'),
          ],
        ),
      ),
    );
  }
}
