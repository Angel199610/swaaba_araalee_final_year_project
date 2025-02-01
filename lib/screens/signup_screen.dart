import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import HomeScreen
import 'dart:ui'; // For BackdropFilter and ImageFilter

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 240, 240, 240), // Light background
      body: Center(
        child: Column(
          children: [
            // Header with image
            Stack(
              children: [
                // Image Container
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'lib/assets/car_image.jpg'), // Your image path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Apply a blur effect
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 2.0, sigmaY: 2.0), // Blur effect applied here
                    child: Container(
                      color: Colors.black
                          .withOpacity(0), // Slight overlay for better effect
                    ),
                  ),
                ),
                // "SIGN UP" Text positioning at the bottom
                Positioned(
                  bottom:
                      20, // Positioning the text at the bottom with some spacing
                  left: 0, // Aligning the text to the left edge of the screen
                  right:
                      0, // Aligning the text to the right edge of the screen (center horizontally)
                  child: Center(
                    // Centering the text horizontally
                    child: Text(
                      "SIGN UP", // The text to display
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(
                                2, 2), // Shadow offset for a slight 3D effect
                            blurRadius: 5, // How much the shadow is blurred
                            color: Colors.black.withOpacity(
                                0.5), // Shadow color with some opacity
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Expanded Card for the form
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 222, 235,
                      247), // Light blue background for form area
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),

                        // Signup title (Removed extra empty title)
                        const Text(
                          "",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),

                        // Full Name Text Field
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Full Names:",
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 14, 13, 13)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(height: 16),

                        // Email Text Field
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Your Email:",
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 10, 10, 10)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),

                        // Password Text Field
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Your Password:",
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 12, 12, 12)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          style: const TextStyle(color: Colors.black),
                          obscureText: true,
                        ),
                        const SizedBox(height: 16),

                        // Confirm Password Text Field
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Confirm Password:",
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 6, 6, 6)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          style: const TextStyle(color: Colors.black),
                          obscureText: true,
                        ),
                        const SizedBox(height: 16),

                        // Sign Up Button
                        ElevatedButton(
                          onPressed: () {
                            // After sign up, navigate to the HomeScreen
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.orange, // Set your desired color
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                          child: const Text("Sign Up"),
                        ),
                        const SizedBox(height: 16),

                        // Login link (Text link to go to Login screen)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account? ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 9, 9, 9)),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(
                                    context); // Go back to previous screen (Login)
                              },
                              child: const Text(
                                "Log in",
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
