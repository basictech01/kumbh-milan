import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String _username = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  String get username => _username;
  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;

  void updateUsername(String value) {
    _username = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    _password = value;
    notifyListeners();
  }

  void updateConfirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

  Future<bool> signUp() async {
    // Add sign-up logic here, such as Firebase authentication
    return true;
  }

  Future<bool> login() async {
    // Add login logic here
    return true;
  }
}
