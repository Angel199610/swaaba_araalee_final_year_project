import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _handleLogin() {
    // Here, you can add validation or authentication logic
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 248),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Card(
              margin: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              color: const Color.fromARGB(255, 44, 50, 60),
              child: Column(
                children: [
                  // Top Image Section
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
                      Positioned(
                        bottom: 10,
                        left: 20,
                        child: Text(
                          "SWAABA ARAALEE",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(offset: Offset(2, 2), blurRadius: 5, color: Colors.black.withOpacity(0.5)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Login Form Section
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "LOG IN",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 20),

                          // Email Input
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: "Your Email:",
                              labelStyle: const TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(color: Colors.orange),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                            ),
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),

                          // Password Input
                          TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelText: "Your Password:",
                              labelStyle: const TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(color: Colors.orange),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                            ),
                            style: const TextStyle(color: Colors.white),
                            obscureText: true,
                          ),
                          const SizedBox(height: 16),

                          // Remember Me Checkbox
                          Row(
                            children: [
                              Checkbox(
                                value: rememberMe,
                                onChanged: (bool? value) {
                                  setState(() {
                                    rememberMe = value ?? false;
                                  });
                                },
                                activeColor: Colors.orange,
                              ),
                              const Text("Remember Me", style: TextStyle(color: Colors.white)),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Login Button
                          ElevatedButton(
                            onPressed: _handleLogin, // Navigate to HomeScreen on login
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 150),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              textStyle: const TextStyle(fontSize: 18),
                            ),
                            child: const Text("Log in"),
                          ),
                          const SizedBox(height: 20),

                          // Register Link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Have no account? ", style: TextStyle(color: Colors.white)),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen()));
                                },
                                child: const Text(
                                  "Register",
                                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




























// import 'package:flutter/material.dart';
// import 'home_screen.dart';
// import 'signup_screen.dart';
// import '../services/auth_service.dart'; // Ensure this service is properly implemented

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool rememberMe = false;
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   void loginUser() async {
//     AuthService authService = AuthService();
//     var response = await authService.login(emailController.text, passwordController.text);

//     if (response.containsKey("token")) {
//       print("Login Successful: ${response['token']}");
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const HomeScreen()),
//       );
//     } else {
//       print("Error: ${response['error']}");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Login failed: ${response['error']}")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 247, 247, 248),
//       body: Center(
//         child: SingleChildScrollView(
//           child: SizedBox(
//             height: MediaQuery.of(context).size.height,
//             child: Card(
//               margin: EdgeInsets.zero,
//               shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//               color: const Color.fromARGB(255, 44, 50, 60),
//               child: Column(
//                 children: [
//                   // Top Image Section
//                   Stack(
//                     children: [
//                       Container(
//                         height: 200,
//                         width: double.infinity,
//                         decoration: const BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage('lib/assets/car_image.jpg'),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 10,
//                         left: 20,
//                         child: Text(
//                           "SWAABA ARAALEE",
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             shadows: [
//                               Shadow(offset: Offset(2, 2), blurRadius: 5, color: Colors.black.withOpacity(0.5)),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   // Login Form Section
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text(
//                             "LOG IN",
//                             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//                           ),
//                           const SizedBox(height: 20),

//                           // Email Input
//                           TextField(
//                             controller: emailController,
//                             decoration: InputDecoration(
//                               labelText: "Your Email:",
//                               labelStyle: const TextStyle(color: Colors.white),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 borderSide: const BorderSide(color: Colors.orange),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 borderSide: const BorderSide(color: Colors.white),
//                               ),
//                             ),
//                             style: const TextStyle(color: Colors.white),
//                             keyboardType: TextInputType.emailAddress,
//                           ),
//                           const SizedBox(height: 16),

//                           // Password Input
//                           TextField(
//                             controller: passwordController,
//                             decoration: InputDecoration(
//                               labelText: "Your Password:",
//                               labelStyle: const TextStyle(color: Colors.white),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 borderSide: const BorderSide(color: Colors.orange),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 borderSide: const BorderSide(color: Colors.white),
//                               ),
//                             ),
//                             style: const TextStyle(color: Colors.white),
//                             obscureText: true,
//                           ),
//                           const SizedBox(height: 16),

//                           // Remember Me Checkbox
//                           Row(
//                             children: [
//                               Checkbox(
//                                 value: rememberMe,
//                                 onChanged: (bool? value) {
//                                   setState(() {
//                                     rememberMe = value ?? false;
//                                   });
//                                 },
//                                 activeColor: Colors.orange,
//                               ),
//                               const Text("Remember Me", style: TextStyle(color: Colors.white)),
//                             ],
//                           ),
//                           const SizedBox(height: 20),

//                           // Login Button
//                           ElevatedButton(
//                             onPressed: loginUser,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.orange,
//                               padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 150),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               textStyle: const TextStyle(fontSize: 18),
//                             ),
//                             child: const Text("Log in"),
//                           ),
//                           const SizedBox(height: 20),

//                           // Register Link
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Text("Have no account? ", style: TextStyle(color: Colors.white)),
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen()));
//                                 },
//                                 child: const Text(
//                                   "Register",
//                                   style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 20),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
