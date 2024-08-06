 import 'package:shared_preferences/shared_preferences.dart';

saveAuthTokenToSharedPreference(String authToken) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("accessToken", authToken);
}

