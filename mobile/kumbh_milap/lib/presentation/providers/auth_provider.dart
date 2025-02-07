import 'package:flutter/material.dart';
import '../../domain/auth_use.dart';

class AuthProvider extends ChangeNotifier {
  //Input fields
  String _username = '';
  String _password = '';
  String _confirmPassword = '';
  String _number = "";
  String _name = "";

  String get number => _number;
  String get username => _username;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  String get name => _name;

  //Output fields
  final AuthUseCase authUseCase;
  bool _isLoading = false;
  String? _errorMessage;

  AuthProvider(this.authUseCase);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void updateUsername(String value) {
    _username = value;
    notifyListeners();
  }

  void updateNumber(String value) {
    _number = value;
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

  void updateName(String value) {
    _name = value;
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await authUseCase.login(username, password);
      _errorMessage = null;
      return true;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }

  Future<bool> signup(
      String username, String password, String phone, String name) async {
    _isLoading = true;
    notifyListeners();

    try {
      await authUseCase.signup(username, password, name, phone);
      _errorMessage = null;
      return true;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }

  Future<void> logout() async {
    await authUseCase.logout();
    notifyListeners();
  }

  Future<bool> isLoggedIn() async {
    return await authUseCase.isLoggedIn();
  }
}
