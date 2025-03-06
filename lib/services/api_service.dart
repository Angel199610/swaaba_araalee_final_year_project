import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _saveToken(data['token']);
      return data;
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<Map<String, dynamic>> getUser() async {
    final token = await getToken();
    if (token == null) throw Exception('No token found');

    final response = await http.get(
      Uri.parse('$baseUrl/user'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch user: ${response.body}');
    }
  }

  Future<void> logout() async {
  final token = await getToken();
  if (token != null) {
    await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('auth_token');
}
}























// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class ApiService {
//   final String baseUrl = "http://your-laravel-backend-url/api";

//   final storage = const FlutterSecureStorage();

//   // Login Method
//   Future<Map<String, dynamic>> login(String email, String password) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/login'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'email': email, 'password': password}),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       await storage.write(key: 'token', value: data['token']);
//       return {'success': true, 'message': "Login successful!"};
//     } else {
//       return {'success': false, 'message': "Invalid credentials"};
//     }
//   }

//   // Signup Method
//   Future<Map<String, dynamic>> register(
//       String name, String email, String password) async {
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
//       await storage.delete(key: 'token');
//     }
//   }
// }
