import 'package:flutter/material.dart';
import 'package:swaaba_aralee/screens/car_categories_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to Swaaba Araalee'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CarCategoriesScreen()));
              },
              child: const Text('View Car Categories'),
            ),
          ],
        ),
      ),
    );
  }
}
