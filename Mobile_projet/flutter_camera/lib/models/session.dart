import 'package:flutter/material.dart';
import 'package:flutter_camera/models/user.dart';

class Session  {
  static Session? _instance;

  // Vous pouvez mettre ici vos API, fonctions de gestion de connexion internet, etc.
  // Par exemple :
  // ApiManager apiManager = ApiManager();
  // NetworkManager networkManager = NetworkManager();

  // Un utilisateur par défaut
  User defaultUser = User(username: 'Utilisateur par défaut');

  // Un constructeur privé pour empêcher l'instanciation directe
  Session._();

  // Une méthode statique pour récupérer l'instance unique de la session
  
}
