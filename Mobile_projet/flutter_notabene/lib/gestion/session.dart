

import 'package:flutter_notabene/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../models/user_model.dart';

class SessionManager {

  late String sessionId;
  late User mainUser;
  int userId=0;
  bool isConnect=false;

  void init(){
    this.sessionId = Uuid().v4();
    mainUser = User.createDefault();
  }

  setuserId(int userId_){
    // mainUser.getUserIdFromLocalStorage(userId_);
    userId = userId_;  
  }
  

   Future<int?> getUserIdFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

}