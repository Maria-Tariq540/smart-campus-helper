import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userName;

  bool get isLoggedIn => _isLoggedIn;
  String? get userName => _userName;

  AuthProvider() {
    _loadAuthState();
  }

  Future<void> login(String email, String password) async {
    // Mock login logic
    if (email.isNotEmpty && password.length >= 6) {
      _isLoggedIn = true;
      _userName = email.split('@')[0];
      await _saveAuthState();
      notifyListeners();
    }
  }

  Future<void> guestLogin() async {
    _isLoggedIn = true;
    _userName = "Guest Student";
    await _saveAuthState();
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    _userName = null;
    await _saveAuthState();
    notifyListeners();
  }

  Future<void> _loadAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _userName = prefs.getString('userName');
    notifyListeners();
  }

  Future<void> _saveAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', _isLoggedIn);
    if (_userName != null) {
      await prefs.setString('userName', _userName!);
    } else {
      await prefs.remove('userName');
    }
  }
}
