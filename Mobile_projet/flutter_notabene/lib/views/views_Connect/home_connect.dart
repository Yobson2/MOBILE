import 'package:flutter/material.dart';
import 'package:flutter_notabene/main.dart';
import 'package:flutter_notabene/screens/login_screen.dart';
import 'package:flutter_notabene/views/carte_view.dart';
import 'package:flutter_notabene/views/photo_view.dart';
import 'package:flutter_notabene/views/views_Connect/profit_connect.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/infosConnexion.dart';
import '../../components/option_component.dart';
import '../home_notconnect.dart';
import '../home_view.dart';
import '../parametres_view.dart';
import 'insertEntrepise.dart';
import 'notification_connect.dart';



class ConnectedUserWidget extends StatefulWidget {
    final String? token;
  const ConnectedUserWidget({this.token, Key? key}) : super(key: key);

  @override
  State<ConnectedUserWidget> createState() => _ConnectedUserWidgetState();
}
class _ConnectedUserWidgetState extends State<ConnectedUserWidget> {
  late int id;
  
  Map<String, dynamic> userData = {};
  int _currentIndex = 0;
   bool printBtn = true;
   bool printBtn2 = true;

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
  _initializeUserData();
}

Future<void> _initializeUserData() async {
  try {
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token!);
    id = jwtDecodedToken['userId'];
    print("object id: " + id.toString());
   
    await _saveUserIdToStorage(id); 
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

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), 
          child: AppBar(
             automaticallyImplyLeading: false,
            backgroundColor: Colors.blue,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0), 
                bottomRight: Radius.circular(10.0),
              ),
            ),
            title:  const Row(
          children: [
            Text(
                'Nota',
                style: TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.bold,
                  fontSize: 20, 
                ),
              ),
              Text(
                'bene',
                style: TextStyle(
                  color: Colors.yellow, 
                  fontWeight: FontWeight.bold,
                  fontSize: 20, 
                ),
              ),
          ],
        ),
        actions: [
          isLoggedIn ?
         Container(
        padding: EdgeInsets.all(2),
        width: 50,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.black12, 
            width: 2.0, 
          ),
        ),
        child: ClipOval(
          child: Image(
            image: NetworkImage(
              'https://images.unsplash.com/photo-1699378999301-8c88a6a237d9?q=80&w=1364&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            ),
            fit: BoxFit.fill,
          ),
        ),
      )

          :IconButton(
            color: Colors.black,
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginForm()),
              );
            },
          )
          
        ],
    
            centerTitle: true,
          ),
        ),

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
             backgroundColor: Colors.black12,
            shape: const CircleBorder(),
             elevation: 5,
            child: Icon(Icons.comment_bank),
            onPressed: () {
              showDialog(
              context: context,
              builder: (BuildContext context) {
                return CategoriesModal();
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








