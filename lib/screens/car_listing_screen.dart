import 'package:flutter/material.dart';

class CarListingScreen extends StatelessWidget {
  const CarListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Car Listings")),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.directions_car),
            title: Text("Car Model $index"),
            subtitle: Text("Price: \$${10000 + index * 500}"),
          );
        },
      ),
    );
  }
}
