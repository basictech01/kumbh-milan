import '../data/auth_repository.dart';
import '../core/shared_pref.dart';

class AuthUseCase {
  final AuthRepository repository;
  final SharedPrefs sharedPrefs;

  AuthUseCase(this.repository, this.sharedPrefs);

  Future<void> login(String username, String password) async {
    final tokens = await repository.login(username, password);
    await sharedPrefs.saveTokens(tokens);
  }

  Future<void> signup(
      String username, String password, String name, String phone) async {
    final tokens = await repository.signup(username, password, name, phone);
    await sharedPrefs.saveTokens(tokens);
  }

  Future<void> logout() async {
    await sharedPrefs.removeAccessToken();
    await sharedPrefs.removeRefreshToken();
  }

  Future<bool> isLoggedIn() async {
    final accessToken = await sharedPrefs.getAccessToken();
    return accessToken != null;
  }
}
