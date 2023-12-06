import 'package:flutter/material.dart';
import 'package:flutter_notabene/main.dart';
import 'package:flutter_notabene/screens/login_screen.dart';
import 'package:flutter_notabene/views/carte_view.dart';
import 'package:flutter_notabene/views/photo_view.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../components/option_component.dart';
import '../../services/api_service.dart';
import '../home_view.dart';
import '../parametres_view.dart';




class ConnectedUserWidget extends StatefulWidget {
    final String? token;
  const ConnectedUserWidget({this.token, Key? key}) : super(key: key);

  @override
  State<ConnectedUserWidget> createState() => _ConnectedUserWidgetState();
}
class _ConnectedUserWidgetState extends State<ConnectedUserWidget> {
  // late int id;
  late int id = 0;
  
  Map<String, dynamic> userData = {};
  int _currentIndex = 0;
   bool printBtn = true;
   bool printBtn2 = true;
   int? userId;
    bool isFirstLogin = true;
  List<Widget> pages = [
    const HomeView(),
    const MapSample(),
    const PhotoViewWithHero(),
    const ParamsView(),
    // const MessageConnexion(),
  ];

@override
void initState() {
  super.initState();
   printBtn = true;
   isFirstLogin = true;
  _initializeUserData();
}

Future<void> _initializeUserData() async {
  try {
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token!);
    id = jwtDecodedToken['userId'];
    print("object id: " + id.toString());
     setState(() {
        this.userId = id;
      }); 

    await _saveUserIdToStorage(id); 
    if (isFirstLogin) {
      // Actualisez la page ici
      setState(() {
        isFirstLogin = false;
      });
    }
  
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Bienvenue ! Vous êtes maintenant connecté.",
            style: TextStyle(
              color: Colors.white, 
              fontSize: 16.0, 
            ),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
      return;

  } catch (e) {
    print('Erreur lors du décodage du token : $e');
  }
}


 Future<void> _saveUserIdToStorage(int? id) async {
  if (id != null) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', id);

    try {
      // final myData = await ApiManager().fetchData("userById/$id","données récupérées","Erreur de récupération des données");
      // if (myData != null && myData.containsKey('users')) {
        setState(() {
          mainSession.userId = id;
          // userData = myData['users']; 
        });
        print("ID enregistré dans le local storage");
        // print("Mes données $userData");
      // } 
    } catch (e) {
      print("Erreur lors de la récupération des données utilisateur : $e");
    }
  } else {
    print("Erreur lors de l'enregistrement de l'ID");
  }
}



  @override
  Widget build(BuildContext context) {
      pages[1] = MapSample(testPrint: printBtn,testPrint2:printBtn2);
     
       final isLoggedIn = mainSession.userId!= 0;
      //  print('connnnnnnn $userId');
      //  final isLoggedIn = userId!= 0;
       pages[0] = HomeView(testConnexion: isFirstLogin);
        pages[3] = ParamsView(testConnexion: isFirstLogin);

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
    floatingActionButton:  isLoggedIn && _currentIndex==0  
    ?  Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
             backgroundColor: Colors.grey[400],
            shape: const CircleBorder(),
             elevation: 5,
            child:const Icon(Icons.comment_bank),
            onPressed: () {
              showDialog(
              context: context,
              builder: (BuildContext context) {
                return const CategoriesModal();
              },
            );
              
            },
          )
        ],
      )
    : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
              if (index == 1) {
              printBtn=false;
              printBtn2=false;
            }

          });
         
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Accueil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Carte",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_camera),
            label: "Photo",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Paramètres",
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        iconSize: 32,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed, 
        backgroundColor: Colors.white, 
        elevation: 10,
       
      ),
    );
  }
}








