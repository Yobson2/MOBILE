import 'package:flutter/material.dart';


import '../screens/Sign_screen.dart';
import '../screens/home_screem.dart';
import '../screens/login_screen.dart';
import '../views/carte_view.dart';
import '../views/cartegories_pages/banque_page.dart';
import '../views/cartegories_pages/divers_page.dart';
import '../views/cartegories_pages/hotel_page.dart';
import '../views/cartegories_pages/restauraut_page.dart';
import '../views/cartegories_pages/spermarche_page.dart';
import '../views/parametres_view.dart';
import '../views/photo_view.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signIn = '/login';
  static const String home = '/';
  static const String carte = '/carte';
  static const String photo = '/photo';


  static const String restaurant = '/restaurant_page';
  static const String banque = '/banque_page';
  static const String hotel = '/hotel_page';
  static const String spermarche = '/spmarche_page';
  static const String divers = '/divers_page';




  static const String parametres = '/parametres';
  static const String homeConnect = '/home/:id';
  static const String listes = '/home/list/:id';
  static const String details = '/home/details/:id';


  static Route<dynamic>? generateRoute(RouteSettings settings)
  {
    switch(settings.name){
      case login:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case signIn:
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
      default:
        return null;
    }
  }
}


