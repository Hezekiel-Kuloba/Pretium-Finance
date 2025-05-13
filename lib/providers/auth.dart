import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretium_finance/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  // Mock login function
  Future<void> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock successful login response
    state = User(
      token: 'mock_token_12345',
      email: email,
      firstName: 'Mock',
      lastName: 'User',
      phone: '+1234567890',
    );
    await _saveToken(state!.token!);
  }

  // Mock signup function
  Future<void> signUp(
    String firstName,
    String lastName,
    String email,
    String phone,
    String password,
  ) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock successful signup response
    state = User(
      token: 'mock_token_12345',
      email: email,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
    );
    await _saveToken(state!.token!);
  }

  // Logout function remains the same as it's already simple
  Future<void> logout() async {
    await _clearToken();
    state = null;
  }

  // Token handling functions remain the same
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  // Check login status remains the same
  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null && token.isNotEmpty) {
      state = User(token: token); // Set user as logged in
      return true;
    }
    return false;
  }
}
