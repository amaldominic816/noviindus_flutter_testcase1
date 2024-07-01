import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:logger/logger.dart';

class AuthProvider with ChangeNotifier {

  final AuthService _authService = AuthService();
  final Logger _logger = Logger();
  bool _isAuthenticated = false;
  String? _errorMessage;

  bool get isAuthenticated => _isAuthenticated;
  String? get errorMessage => _errorMessage;

  Future<void> login(String username, String password) async {
    _errorMessage = null;
    _logger.i('Login process started for user: $username');
    try {
      _isAuthenticated = await _authService.login(username, password);
      if (_isAuthenticated) {
        _logger.i('User $username logged in successfully.');
      } else {
        _errorMessage = 'Login failed: Invalid username or password';
        _logger.w('User $username failed to log in.');
      }
    } catch (e) {
      _errorMessage = 'Login failed: ${e.toString()}';
      _logger.e('Login error: $e');
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.logout();
    _isAuthenticated = false;
    _logger.i('User logged out.');
    notifyListeners();
  }

  Future<void> checkAuthentication() async {
    final token = await _authService.getToken();
    _isAuthenticated = token != null;
    _logger.i('Checked authentication state: $_isAuthenticated');
    notifyListeners();
  }
}
