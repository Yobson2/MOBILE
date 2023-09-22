import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  Future<int?> getUserIdFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }
}
