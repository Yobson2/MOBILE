import 'package:flutter/material.dart';
import 'package:flutter_notabene/screens/Sign_screen.dart';
import 'package:flutter_notabene/screens/home_screem.dart';
import 'package:flutter_notabene/views/carte_view.dart';
import 'package:flutter_notabene/views/cartegories_pages/banque_page.dart';
import 'package:flutter_notabene/views/cartegories_pages/hotel_page.dart';
import 'package:flutter_notabene/views/cartegories_pages/restauraut_page.dart';
import 'package:flutter_notabene/views/parametres_view.dart';
import 'package:flutter_notabene/views/photo_view.dart';
import 'package:flutter_notabene/views/sectionBlocs/details_items.dart';
import 'package:flutter_notabene/views/sectionBlocs/listes_sections.dart';

import '../screens/login_screen.dart';
import '../views/cartegories_pages/divers_page.dart';
import '../views/cartegories_pages/spermarche_page.dart';

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

  static const String restaurant = '/restaurant_page';
  static const String banque = '/banque_page';
  static const String hotel = '/hotel_page';
  static const String spermarche = '/spmarche_page';
  static const String divers = '/divers_page';


  static Route<dynamic>? generateRoute(RouteSettings settings)
  {
    switch(settings.name){
      case login:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (context) => RegistrationPage());
      case home:
        return MaterialPageRoute(builder: (context) => const HomeScreem());
      case carte:
        return MaterialPageRoute(builder: (context) => const CarteGloblale());
      case photo:
        return MaterialPageRoute(builder: (context) =>  const PhotoViewWithHero());
      case parametres:
        return MaterialPageRoute(builder: (context) => const ParamsView());
      case banque:
        return MaterialPageRoute(builder: (context) => const BanquePage());
      case restaurant:
        return MaterialPageRoute(builder: (context) => const RestaurantPage());
      
      case hotel:
        return MaterialPageRoute(builder: (context) => const HotelPage());
      case spermarche :
        return MaterialPageRoute(builder: (context) => const SpermarchePage());
      case divers :
        return MaterialPageRoute(builder: (context) => const DiversPage());
      case homeConnect:
        // return MaterialPageRoute(builder: (context) => HomeConnectScreen());
      case listes:
        return MaterialPageRoute(builder: (context) => const ListesBlocItems());
      case details:
        return MaterialPageRoute(builder: (context) => const MyDetailsItems());
      default:
        return null;
    }
  }
}


