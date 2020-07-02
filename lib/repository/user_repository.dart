part of 'repository.dart';

class UserRepository {
  Future<String> login({String email, String password}) async {
    await Future.delayed(Duration(seconds: 1));
    return 'token123';
  }

  Future<void> deleteToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("token", "");
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("token", token);
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString("token");
    await Future.delayed(Duration(seconds: 1));
    return token != null && token.isNotEmpty;
  }
}
