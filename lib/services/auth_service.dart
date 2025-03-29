import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/api.dart';

class AuthService {
  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Singleton instance
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  // Signup method
  Future<Map<String, dynamic>> register(String name, String email,
      String password, String passwordConfirmation) async {
    try {
      Response response = await _dio.post(
        '${API.baseUrl}/register',
        data: {
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
        ),
      );

      print("Register Response Status: ${response.statusCode}");
      print("Register Response Body: ${response.data.toString()}");

      String? token = response.data["token"]?.toString();
      if (token == null) {
        print("Register response has no token: ${response.data}");
        throw Exception("Token not found in API response");
      }

      await _storage.write(key: "token", value: token);
      print("Token stored after register: $token");
      print("Stored tokens after register: ${await _storage.readAll()}");

      return response.data;
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  // Login method
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        '${API.baseUrl}/public/login',
        data: {
          "email": email,
          "password": password,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
        ),
      );

      print("Login Response Status: ${response.statusCode}");
      print("Login Response Body: ${response.data.toString()}");

      String? token = response.data["token"]?.toString();
      if (token == null) {
        print("Login response has no token: ${response.data}");
        throw Exception("Token not found in API response");
      }

      // Ensure the token is written and synced
      await _storage.write(key: "token", value: token);
      print("Token stored after login: $token");

      // Verify the token was saved by reading it back immediately
      String? savedToken = await _storage.read(key: "token");
      print("Immediately retrieved token after login: $savedToken");
      if (savedToken != token) {
        print("Error: Token not saved correctly");
        throw Exception("Failed to save token");
      }

      print("Stored tokens after login: ${await _storage.readAll()}");
      return response.data;
    } on DioException catch (e) {
      print("Login Error: ${e.response?.data["message"] ?? e.message}");
      throw Exception(e.response?.data["message"] ?? "Login failed");
    } catch (e) {
      print("Unexpected error during login: $e");
      throw Exception("Unexpected error during login: $e");
    }
  }

  // Logout method
  Future<void> logout() async {
    try {
      String? token = await getToken();

      if (token != null) {
        await _dio.post(
          '${API.baseUrl}/logout',
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
              "Accept": "application/json"
            },
          ),
        );
      }

      await _storage.delete(key: "token");
      print("Token deleted after logout");
    } on DioException catch (e) {
      print("Logout Error: ${e.message}");
    }
  }

  // Get token
  Future<String?> getToken() async {
    try {
      final token = await _storage.read(key: "token");
      print("Retrieved token in AuthService: $token");
      return token;
    } catch (e) {
      print("Error retrieving token: $e");
      return null;
    }
  }

  // Handle Dio errors
  Map<String, dynamic> _handleDioError(DioException e) {
    if (e.response != null) {
      print("Response Data: ${e.response?.data}");
      return {
        "error": true,
        "message": e.response?.data['message'] ?? 'Something went wrong',
        "statusCode": e.response?.statusCode
      };
    } else {
      if (kDebugMode) {
        print("Error: ${e.message}");
      }
      return {"error": true, "message": e.message};
    }
  }

  Future<void> refreshToken() async {
    // Implement token refresh logic if needed
  }
}
