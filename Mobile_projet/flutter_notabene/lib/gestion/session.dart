

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_notabene/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../models/user_model.dart';

class SessionManager {
  //Receperer les images de la galerie
    List<dynamic> selectedImageUrl_=[];
    String entreprise="";
    String motCommentaire="";
    String categorie="";
    int taille=0;
    int nbreTolalEtoille=0;
    

  late String sessionId;
  late User mainUser;
  int userId=0;
  bool isConnect=false;

  void init(){
    this.sessionId = Uuid().v4();
    mainUser = User.createDefault();
  }


  setuserId(int userId_){
    userId = userId_;  
  }


  setCategorie(String mot){
    categorie=mot;
  }
  setItemsLength(int item){
    taille=item;
  }
  setCalNumEtoille(int item){
    nbreTolalEtoille= item ~/taille;
  }
 
  

   Future<int?> getUserIdFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

}