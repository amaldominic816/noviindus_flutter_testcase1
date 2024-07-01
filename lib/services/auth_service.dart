import 'package:dio/dio.dart';
import 'package:flutter_testcase_one/constants/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class AuthService {
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  Future<bool> login(String username, String password) async {
    _logger.i('Attempting to log in user: $username');
    _logger.d('Username: $username, Password: $password'); // log username and password
    try {
      final response = await _dio.post("${API().baseUrl}${API().Login}", data: FormData.fromMap({
        'username': username,
        'password': password,
      }),
      );

      _logger.d('Login API response: $response'); // log API response

      if (response.data['status']) {
        final token = response.data['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        _logger.i('Login successful, token stored.');
        return true;
      } else {
        _logger.w('Login failed: ${response.data['message']}');
        return false;
      }
    } catch (e) {
      _logger.e('Login error: $e');
      return false;
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _logger.i('User logged out, token removed.');
  }
}
