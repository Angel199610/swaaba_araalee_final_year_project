import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String _baseUrl = 'http://127.0.0.1:8000/api';
  static const String _tokenKey = 'auth_token';

  // Singleton instance
  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  ApiService._internal();

  Future<void> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        await _saveToken(data['token']);
      } else {
        throw Exception('Registration failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error during registration: $e');
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/public/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print("Login Response Status: ${response.statusCode}");
      print("Login Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'] ?? data['access_token'];
        if (token == null) {
          throw Exception('Token not found in API response');
        }
        print("Token received from API: $token");
        await _saveToken(token);
        final savedToken = await getToken();
        print("Token after saving: $savedToken");
        if (savedToken != token) {
          throw Exception('Token mismatch after saving');
        }
        return data;
      } else {
        throw Exception('Login failed: ${response.body}');
      }
    } catch (e) {
      print("Login Error: $e");
      throw Exception('Error during login: $e');
    }
  }

  Future<void> _saveToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, token);
      print("Token saved to SharedPreferences: $token");
    } catch (e) {
      print("Error saving token: $e");
      throw Exception('Failed to save token: $e');
    }
  }

  Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(_tokenKey);
      print("Retrieved token from SharedPreferences: $token");
      return token;
    } catch (e) {
      print("Error retrieving token: $e");
      throw Exception('Failed to retrieve token: $e');
    }
  }

  Future<Map<String, dynamic>> getUser() async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('No token found. Please log in.');
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/user'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch user: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching user: $e');
    }
  }

  Future<void> logout() async {
    try {
      final token = await getToken();
      if (token != null) {
        final response = await http.post(
          Uri.parse('$_baseUrl/logout'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode != 200) {
          throw Exception('Logout failed: ${response.body}');
        }
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);
    } catch (e) {
      throw Exception('Error during logout: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getHybridCars() async {
    try {
      final token = await getToken();
      if (token == null) {
        throw Exception('No token found. Please log in.');
      }

      final response = await http.get(
        Uri.parse('$_baseUrl/hybrid-cars'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load hybrid cars: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching hybrid cars: $e');
    }
  }
}



























// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class ApiService {
//   static const String _baseUrl = 'http://127.0.0.1:8000/api';
//   static const String _tokenKey = 'auth_token';

//   Future<void> register(String name, String email, String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$_baseUrl/register'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'name': name,
//           'email': email,
//           'password': password,
//         }),
//       );

//       if (response.statusCode == 201) {
//         final data = jsonDecode(response.body);
//         await _saveToken(data['token']);
//       } else {
//         throw Exception('Registration failed: ${response.body}');
//       }
//     } catch (e) {
//       throw Exception('Error during registration: $e');
//     }
//   }

//   Future<Map<String, dynamic>> login(String email, String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$_baseUrl/public/login'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//         body: jsonEncode({
//           'email': email,
//           'password': password,
//         }),
//       );

//       print("Login Response Status: ${response.statusCode}");
//       print("Login Response Body: ${response.body}");

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final token = data['token'] ?? data['access_token'];
//         if (token == null) {
//           throw Exception('Token not found in API response');
//         }
//         print("Token received from API: $token");
//         await _saveToken(token);
//         final savedToken = await getToken();
//         print("Token after saving: $savedToken");
//         if (savedToken != token) {
//           throw Exception('Token mismatch after saving');
//         }
//         return data;
//       } else {
//         throw Exception('Login failed: ${response.body}');
//       }
//     } catch (e) {
//       print("Login Error: $e");
//       throw Exception('Error during login: $e');
//     }
//   }

//   Future<void> _saveToken(String token) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString(_tokenKey, token);
//       print("Token saved to SharedPreferences: $token");
//     } catch (e) {
//       print("Error saving token: $e");
//       throw Exception('Failed to save token: $e');
//     }
//   }

//   Future<String?> getToken() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString(_tokenKey);
//       print("Retrieved token from SharedPreferences: $token");
//       return token;
//     } catch (e) {
//       print("Error retrieving token: $e");
//       throw Exception('Failed to retrieve token: $e');
//     }
//   }

//   Future<Map<String, dynamic>> getUser() async {
//     try {
//       final token = await getToken();
//       if (token == null) {
//         throw Exception('No token found. Please log in.');
//       }

//       final response = await http.get(
//         Uri.parse('$_baseUrl/user'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         throw Exception('Failed to fetch user: ${response.body}');
//       }
//     } catch (e) {
//       throw Exception('Error fetching user: $e');
//     }
//   }

//   Future<void> logout() async {
//     try {
//       final token = await getToken();
//       if (token != null) {
//         final response = await http.post(
//           Uri.parse('$_baseUrl/logout'),
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         );

//         if (response.statusCode != 200) {
//           throw Exception('Logout failed: ${response.body}');
//         }
//       }

//       final prefs = await SharedPreferences.getInstance();
//       await prefs.remove(_tokenKey);
//     } catch (e) {
//       throw Exception('Error during logout: $e');
//     }
//   }

//   Future<List<Map<String, dynamic>>> getHybridCars() async {
//     try {
//       final token = await getToken();
//       if (token == null) {
//         throw Exception('No token found. Please log in.');
//       }

//       final response = await http.get(
//         Uri.parse('$_baseUrl/hybrid-cars'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body) as List;
//         return data.cast<Map<String, dynamic>>();
//       } else {
//         throw Exception('Failed to load hybrid cars: ${response.body}');
//       }
//     } catch (e) {
//       throw Exception('Error fetching hybrid cars: $e');
//     }
//   }
// }