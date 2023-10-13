import 'package:flutter/material.dart';
import 'package:flutter_notabene/screens/Sign_screen.dart';
import 'package:flutter_notabene/screens/home_screem.dart';
import 'package:flutter_notabene/views/carte_view.dart';
import 'package:flutter_notabene/views/parametres_view.dart';
import 'package:flutter_notabene/views/photo_view.dart';
import 'package:flutter_notabene/views/items/details_items.dart';
import 'package:flutter_notabene/views/items/listes_sections.dart';

import '../screens/login_screen.dart';


class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/';
  static const String carte = '/carte';
  static const String photo = '/photo';

  static const String parametres = '/parametres';
  static const String homeConnect = '/home/:id';
  static const String listes = '/home/list/:id';
  static const String details = '/home/details/:id';



  static Route<dynamic>? generateRoute(RouteSettings settings)
  {
    switch(settings.name){
      case login:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (context) => RegistrationPage());
      case home:
        return MaterialPageRoute(builder: (context) =>  const HomeScreen());
      case carte:
        return MaterialPageRoute(builder: (context) => const MapSample());
      case photo:
        return MaterialPageRoute(builder: (context) =>  const PhotoViewWithHero());
      case parametres:
        return MaterialPageRoute(builder: (context) => const ParamsView());
      case listes:
        return MaterialPageRoute(builder: (context) =>  ListesBlocItems());
      case details:
        return MaterialPageRoute(builder: (context) => const MyDetailsItems());
      default:
        return null;
    }
  }
}


