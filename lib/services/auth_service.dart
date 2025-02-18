import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/api.dart';

class AuthService {
  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = FlutterSecureStorage();

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

      await _storage.write(key: "token", value: response.data["token"]);

      return response.data;
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  // Login method
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        '${API.baseUrl}/login',
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

      await _storage.write(key: "token", value: response.data["token"]);

      return response.data;
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  // Logout method
  Future<void> logout() async {
    try {
      String? token = await _storage.read(key: "token");

      await _dio.post(
        '${API.baseUrl}/logout',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          },
        ),
      );

      await _storage.delete(key: "token");
    } on DioException catch (e) {
      print("Logout Error: ${e.message}");
    }
  }

  // Get token
  Future<String?> getToken() async {
    return await _storage.read(key: "token");
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
}
