import 'package:flutter/material.dart';

class CarDetailsScreen extends StatelessWidget {
  const CarDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Car Details")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network("https://via.placeholder.com/150"),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Car Model",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Price: \$25,000"),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Description of the car goes here."),
          ),
        ],
      ),
    );
  }
}
