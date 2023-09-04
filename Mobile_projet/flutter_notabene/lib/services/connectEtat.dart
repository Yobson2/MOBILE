import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  int? userId;

  void setUser(int id) {
    userId = id;
    notifyListeners();
  }
}

