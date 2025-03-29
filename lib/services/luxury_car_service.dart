import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/auth_service.dart';

class LuxuryCarService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  static Future<List<Map<String, dynamic>>> fetchLuxuryCars({String? brand}) async {
    try {
      final authService = AuthService();
      final token = await authService.getToken();
      print("Retrieved token in LuxuryCarService: $token");

      if (token == null) {
        throw Exception('No authentication token found. Please log in.');
      }

      final uri = Uri.parse('$baseUrl/luxury-cars').replace(queryParameters: brand != null ? {'brand': brand} : null);
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print("API Response Status: ${response.statusCode}");
      print("API Response Body: ${response.body}");

      if (response.statusCode == 200) {
        try {
          final data = json.decode(response.body);
          if (data['cars'] == null) {
            print("No luxury cars found in response");
            return [];
          }
          return List<Map<String, dynamic>>.from(data['cars']);
        } catch (e) {
          print("JSON Parsing Error: $e");
          throw Exception("Failed to parse luxury cars data: $e");
        }
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Invalid or expired token');
      } else {
        throw Exception('Failed to load luxury cars: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print("LuxuryCarService Error: $e");
      throw Exception("Error fetching luxury cars: $e");
    }
  }
}