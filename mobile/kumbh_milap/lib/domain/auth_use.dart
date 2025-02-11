import '../data/auth_repository.dart';
import '../core/shared_pref.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthUseCase {
  final AuthRepository repository;
  final SharedPrefs sharedPrefs;

  AuthUseCase(this.repository, this.sharedPrefs);

  Future<void> login(String username, String password) async {
    final tokens = await repository.login(username, password);
    await sharedPrefs.saveTokensAndUserId(tokens);
  }

  Future<void> signup(
      String username, String password, String name, String phone) async {
    final tokens = await repository.signup(username, password, name, phone);
    await sharedPrefs.saveTokensAndUserId(tokens);
  }

  Future<bool> isLoggedIn() async {
    final accessToken = await sharedPrefs.getAccessToken();
    if (accessToken == null) {
      return false;
    }
    DateTime expirationDate = JwtDecoder.getExpirationDate(accessToken);
    print(expirationDate);
    if (JwtDecoder.isExpired(accessToken)) {
      final isRefreshValid = await repository.refreshAccessToken();
      if (!isRefreshValid) {
        return false;
      }
    }
    return true;
  }
}
