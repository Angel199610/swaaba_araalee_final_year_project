import 'dart:ui';
import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Adjust path if needed

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final ApiService _apiService = ApiService();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> registerUser() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    try {
      await _apiService.register(
        nameController.text,
        emailController.text,
        passwordController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration successful!")),
      );
      Navigator.pushNamed(context, '/login'); // Navigate to login screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      body: Center(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/car_image.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                    child: Container(color: Colors.black.withOpacity(0)),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 5,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 222, 235, 247),
                  borderRadius: BorderRadius.only(
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
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: "Names:",
                            labelStyle: const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: "Your Email:",
                            labelStyle: const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: "Your Password:",
                            labelStyle: const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                            labelText: "Confirm Password:",
                            labelStyle: const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: registerUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                          child: const Text("Register"), // Fixed typo
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already registered? ",
                              style: TextStyle(color: Colors.black),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/login');
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






































// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   _SignupScreenState createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   // Controllers for text fields
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();

//   @override
//   void dispose() {
//     // Dispose controllers to free memory
//     nameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }

//   // Call the API to register
//   Future<void> registerUser() async {
//     // Check if fields are not empty
//     if (nameController.text.isEmpty ||
//         emailController.text.isEmpty ||
//         passwordController.text.isEmpty ||
//         confirmPasswordController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please fill all fields")),
//       );
//       return;
//     }

//     // Check if passwords match
//     if (passwordController.text != confirmPasswordController.text) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Passwords do not match")),
//       );
//       return;
//     }

//     // Sending the registration request to Laravel API
//     final response = await http.post(
//       Uri.parse(
//           'http://127.0.0.1:8000/register'), // API url
//       body: json.encode({
//         'name': nameController.text,
//         'email': emailController.text,
//         'password': passwordController.text,
//         'password_confirmation': confirmPasswordController.text,
//       }),
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 200) {
//       // If the registration is successful
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Registration successful!")),
//       );
//     } else {
//       // If there is an error
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Registration failed!")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 240, 240, 240),
//       body: Center(
//         child: Column(
//           children: [
//             // Header with image
//             Stack(
//               children: [
//                 Container(
//                   height: 200,
//                   width: double.infinity,
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('lib/assets/car_image.jpg'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Positioned.fill(
//                   child: BackdropFilter(
//                     filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
//                     child: Container(color: Colors.black.withOpacity(0)),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 20,
//                   left: 0,
//                   right: 0,
//                   child: Center(
//                     child: Text(
//                       "SIGN UP",
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         shadows: [
//                           Shadow(
//                             offset: Offset(2, 2),
//                             blurRadius: 5,
//                             color: Colors.black.withOpacity(0.5),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             // Expanded Card for the form
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 222, 235, 247),
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(40),
//                     topRight: Radius.circular(40),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         const SizedBox(height: 20),

//                         // Full Name Text Field
//                         TextField(
//                           controller: nameController,
//                           decoration: InputDecoration(
//                             labelText: "Names:",
//                             labelStyle: const TextStyle(color: Colors.black),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 16),

//                         // Email Text Field
//                         TextField(
//                           controller: emailController,
//                           decoration: InputDecoration(
//                             labelText: "Your Email:",
//                             labelStyle: const TextStyle(color: Colors.black),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                           ),
//                           keyboardType: TextInputType.emailAddress,
//                         ),
//                         const SizedBox(height: 16),

//                         // Password Text Field
//                         TextField(
//                           controller: passwordController,
//                           decoration: InputDecoration(
//                             labelText: "Your Password:",
//                             labelStyle: const TextStyle(color: Colors.black),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                           ),
//                           obscureText: true,
//                         ),
//                         const SizedBox(height: 16),

//                         // Confirm Password Text Field
//                         TextField(
//                           controller: confirmPasswordController,
//                           decoration: InputDecoration(
//                             labelText: "Confirm Password:",
//                             labelStyle: const TextStyle(color: Colors.black),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                           ),
//                           obscureText: true,
//                         ),
//                         const SizedBox(height: 16),

//                         // Sign Up Button
//                         ElevatedButton(
//                           onPressed: registerUser,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.orange,
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             textStyle: const TextStyle(fontSize: 18),
//                           ),
//                           child: const Text("Regsiter"),
//                         ),
//                         const SizedBox(height: 16),

//                         // Login link
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               "Already registered",
//                               style: TextStyle(color: Colors.black),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.pop(context);
//                               },
//                               child: const Text(
//                                 "Log in",
//                                 style: TextStyle(
//                                   color: Colors.orange,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }























// import 'package:flutter/material.dart';
// // Import HomeScreen
// import 'dart:ui'; // For BackdropFilter and ImageFilter

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   _SignupScreenState createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   // Controllers for text fields
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();

//   @override
//   void dispose() {
//     // Dispose controllers to free memory
//     nameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 240, 240, 240),
//       body: Center(
//         child: Column(
//           children: [
//             // Header with image
//             Stack(
//               children: [
//                 Container(
//                   height: 200,
//                   width: double.infinity,
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('lib/assets/car_image.jpg'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Positioned.fill(
//                   child: BackdropFilter(
//                     filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
//                     child: Container(color: Colors.black.withOpacity(0)),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 20,
//                   left: 0,
//                   right: 0,
//                   child: Center(
//                     child: Text(
//                       "SIGN UP",
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         shadows: [
//                           Shadow(
//                             offset: Offset(2, 2),
//                             blurRadius: 5,
//                             color: Colors.black.withOpacity(0.5),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             // Expanded Card for the form
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 222, 235, 247),
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(40),
//                     topRight: Radius.circular(40),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         const SizedBox(height: 20),

//                         // Full Name Text Field
//                         TextField(
//                           controller: nameController,
//                           decoration: InputDecoration(
//                             labelText: "Full Names:",
//                             labelStyle: const TextStyle(color: Colors.black),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 16),

//                         // Email Text Field
//                         TextField(
//                           controller: emailController,
//                           decoration: InputDecoration(
//                             labelText: "Your Email:",
//                             labelStyle: const TextStyle(color: Colors.black),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                           ),
//                           keyboardType: TextInputType.emailAddress,
//                         ),
//                         const SizedBox(height: 16),

//                         // Password Text Field
//                         TextField(
//                           controller: passwordController,
//                           decoration: InputDecoration(
//                             labelText: "Your Password:",
//                             labelStyle: const TextStyle(color: Colors.black),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                           ),
//                           obscureText: true,
//                         ),
//                         const SizedBox(height: 16),

//                         // Confirm Password Text Field
//                         TextField(
//                           controller: confirmPasswordController,
//                           decoration: InputDecoration(
//                             labelText: "Confirm Password:",
//                             labelStyle: const TextStyle(color: Colors.black),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                           ),
//                           obscureText: true,
//                         ),
//                         const SizedBox(height: 16),

//                         // Sign Up Button
//                         ElevatedButton(
//                           onPressed: () {
//                             // Sign-up logic will be added here in the future
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(content: Text("Sign-up clicked!")),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.orange,
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             textStyle: const TextStyle(fontSize: 18),
//                           ),
//                           child: const Text("Sign Up"),
//                         ),
//                         const SizedBox(height: 16),

//                         // Login link
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               "Already have an account? ",
//                               style: TextStyle(color: Colors.black),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.pop(context);
//                               },
//                               child: const Text(
//                                 "Log in",
//                                 style: TextStyle(
//                                   color: Colors.orange,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


































// import 'package:flutter/material.dart';
// import 'home_screen.dart'; // Import HomeScreen
// import 'dart:ui'; // For BackdropFilter and ImageFilter
// import '../services/auth_service.dart'; // Ensure AuthService is implemented

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   _SignupScreenState createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   // Controllers for text fields
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();

//   // Function to handle sign-up
//   void registerUser() async {
//     AuthService authService =
//         AuthService(); // Ensure AuthService is implemented
//     var response = await authService.register(
//       nameController.text,
//       emailController.text,
//       passwordController.text,
//       confirmPasswordController.text,
//     );

//     if (response.containsKey("token")) {
//       print("Signup Successful: ${response['token']}");
//       // Navigate to HomeScreen
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const HomeScreen()),
//       );
//     } else {
//       // Show error message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: ${response['error']}")),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     // Dispose controllers to free memory
//     nameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:
//           const Color.fromARGB(255, 240, 240, 240), // Light background
//       body: Center(
//         child: Column(
//           children: [
//             // Header with image
//             Stack(
//               children: [
//                 // Image Container
//                 Container(
//                   height: 200,
//                   width: double.infinity,
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(
//                           'lib/assets/car_image.jpg'), // Your image path
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 // Apply a blur effect
//                 Positioned.fill(
//                   child: BackdropFilter(
//                     filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
//                     child: Container(
//                         color:
//                             Colors.black.withOpacity(0)), // Transparent overlay
//                   ),
//                 ),
//                 // "SIGN UP" Text positioning
//                 Positioned(
//                   bottom: 20,
//                   left: 0,
//                   right: 0,
//                   child: Center(
//                     child: Text(
//                       "SIGN UP",
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         shadows: [
//                           Shadow(
//                             offset: Offset(2, 2),
//                             blurRadius: 5,
//                             color: Colors.black.withOpacity(0.5),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             // Expanded Card for the form
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(
//                       255, 222, 235, 247), // Light blue background
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(40),
//                     topRight: Radius.circular(40),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         const SizedBox(height: 20),

//                         // Full Name Text Field
//                         TextField(
//                           controller: nameController,
//                           decoration: InputDecoration(
//                             labelText: "Full Names:",
//                             labelStyle: const TextStyle(color: Colors.black),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 16),

//                         // Email Text Field
//                         TextField(
//                           controller: emailController,
//                           decoration: InputDecoration(
//                             labelText: "Your Email:",
//                             labelStyle: const TextStyle(color: Colors.black),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                           ),
//                           keyboardType: TextInputType.emailAddress,
//                         ),
//                         const SizedBox(height: 16),

//                         // Password Text Field
//                         TextField(
//                           controller: passwordController,
//                           decoration: InputDecoration(
//                             labelText: "Your Password:",
//                             labelStyle: const TextStyle(color: Colors.black),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                           ),
//                           obscureText: true,
//                         ),
//                         const SizedBox(height: 16),

//                         // Confirm Password Text Field
//                         TextField(
//                           controller: confirmPasswordController,
//                           decoration: InputDecoration(
//                             labelText: "Confirm Password:",
//                             labelStyle: const TextStyle(color: Colors.black),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                           ),
//                           obscureText: true,
//                         ),
//                         const SizedBox(height: 16),

//                         // Sign Up Button
//                         ElevatedButton(
//                           onPressed: registerUser, // Call register function
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.orange,
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             textStyle: const TextStyle(fontSize: 18),
//                           ),
//                           child: const Text("Sign Up"),
//                         ),
//                         const SizedBox(height: 16),

//                         // Login link
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               "Already have an account? ",
//                               style: TextStyle(color: Colors.black),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.pop(context); // Go back to Login
//                               },
//                               child: const Text(
//                                 "Log in",
//                                 style: TextStyle(
//                                   color: Colors.orange,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
