// models/user_model.dart
class User {
  final String? token;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? pin;
  bool get isLoggedIn => token != null && token!.isNotEmpty;

  User({
    this.token,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.pin,
  });

  // Add fromJson/toJson if needed for mock data
}
