// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class ApiService {
//   final String baseUrl = "http://your-laravel-backend-url/api"; // Update this

//   final storage = const FlutterSecureStorage(); // Secure token storage

//   // Login Method
//   Future<Map<String, dynamic>> login(String email, String password) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/login'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'email': email, 'password': password}),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       await storage.write(key: 'token', value: data['token']); // Save token
//       return {'success': true, 'message': "Login successful!"};
//     } else {
//       return {'success': false, 'message': "Invalid credentials"};
//     }
//   }

//   // Signup Method
//   Future<Map<String, dynamic>> register(String name, String email, String password) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/register'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'name': name, 'email': email, 'password': password}),
//     );

//     if (response.statusCode == 201) {
//       return {'success': true, 'message': "Registration successful!"};
//     } else {
//       return {'success': false, 'message': "Error registering user"};
//     }
//   }

//   // Logout Method
//   Future<void> logout() async {
//     String? token = await storage.read(key: 'token');
//     if (token != null) {
//       await http.post(
//         Uri.parse('$baseUrl/logout'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );
//       await storage.delete(key: 'token'); // Remove token on logout
//     }
//   }
// }
