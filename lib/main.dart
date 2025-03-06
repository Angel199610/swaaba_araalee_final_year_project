import 'package:flutter/material.dart';
import './screens/splash_screen.dart';
import './screens/login_screen.dart';
import './screens/signup_screen.dart';
import './screens/home_screen.dart'; // Add this (create below)

void main() {
  runApp(const SwaabaAraaleeApp());
}

class SwaabaAraaleeApp extends StatelessWidget {
  const SwaabaAraaleeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swaaba Araalee',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

// import 'package:swaaba_aralee/core.dart';
// import 'package:flutter/material.dart';
// import './screens/splash_screen.dart';

// void main() {
//   runApp(SwaabaAraaleeApp());
// }

// class SwaabaAraaleeApp extends StatelessWidget {
//   const SwaabaAraaleeApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Swaaba Araalee',
//       navigatorKey: Get.navigatorKey,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: SplashScreen(),
//       debugShowCheckedModeBanner: false, // Hides the debug banner
//     );
//   }
// }

// class Get {
//   static var navigatorKey;
// }
