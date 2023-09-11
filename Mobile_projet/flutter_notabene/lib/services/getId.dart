 import 'package:shared_preferences/shared_preferences.dart';

Future<int?> _getUserIdFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }