

import 'package:flutter_notabene/main.dart';
import 'package:uuid/uuid.dart';

import '../models/user_model.dart';

class SessionManager {

  late String sessionId;
  late User mainUser;
  int userId=0;

  void init(){
    this.sessionId = Uuid().v4();
    mainUser = User.createDefault();
  }

  setuserId(int userId_){
    mainUser.getUserIdFromLocalStorage(userId_);
    userId = userId_;  
  }
  

}