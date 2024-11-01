import 'package:swaaba_aralee/core.dart';
import 'package:flutter/material.dart';
import './screens/splash_screen.dart';

void main() {
  runApp(SwaabaAraaleeApp());
}

class SwaabaAraaleeApp extends StatelessWidget {
  const SwaabaAraaleeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swaaba Araalee',
      navigatorKey: Get.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false, // Hides the debug banner
    );
  }
}

class Get {
  static var navigatorKey;
}
