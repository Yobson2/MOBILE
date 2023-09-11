import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  int? userId;

  void setUser(int id) {
    userId = id;
    notifyListeners();
  }

  Future<void> setUserIdToStorage(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', id);
  }

  Future<void> getUserIdFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('user_id');
  }
}
