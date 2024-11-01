import 'package:flutter/material.dart';

class ComparisonScreen extends StatelessWidget {
  const ComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Compare Cars")),
      body: ListView(
        children: const [
          ListTile(
            title: Text("Car 1"),
            subtitle: Text("Features and specifications"),
          ),
          ListTile(
            title: Text("Car 2"),
            subtitle: Text("Features and specifications"),
          ),
        ],
      ),
    );
  }
}
