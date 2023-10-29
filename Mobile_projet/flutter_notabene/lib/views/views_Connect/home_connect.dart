import 'package:flutter/material.dart';
import 'package:flutter_notabene/main.dart';
import 'package:flutter_notabene/screens/login_screen.dart';
import 'package:flutter_notabene/views/carte_view.dart';
import 'package:flutter_notabene/views/photo_view.dart';
import 'package:flutter_notabene/views/views_Connect/profit_connect.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/option_component.dart';
import '../home_notconnect.dart';
import '../home_view.dart';
import 'insertEntrepise.dart';
import 'notification_connect.dart';



class ConnectedUserWidget extends StatefulWidget {
    final String token;
  const ConnectedUserWidget({required this.token, Key? key}) : super(key: key);

  @override
  State<ConnectedUserWidget> createState() => _ConnectedUserWidgetState();
}
class _ConnectedUserWidgetState extends State<ConnectedUserWidget> {
  late int id;
  
  Map<String, dynamic> userData = {};
  int _currentIndex = 0;

  List<Widget> pages = [
    const HomeView(),
    const MapSample(),
    const PhotoViewWithHero(),
    const Text("Bienvenue,"),
    
  ];

@override
void initState() {
  super.initState();
  _initializeUserData();
}

Future<void> _initializeUserData() async {
  try {
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
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


  void _showSettingsModal(BuildContext context) {
    showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.0),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Paramètres',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Profil'),
              onTap: () {
                 Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NoteUserWidget()),
              );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.notification_add),
              title: const Text('Notifications'),
              onTap: () {
                
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotifUserWidget()),
              );
              },
            ),
             const Divider(),
            ListTile(
              leading: const Icon(Icons.create),
              title: const Text('Entreprise'),
              onTap: () {
              
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const  InsertCompagnyWidget()),
              );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Quitter'),
              onTap: () {
                 Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotConnectedUserWidget()),
              );
              },
            ),
          ],
        ),
      );
    },
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading: false,
        title: const Row(
          children: [
            Icon(Icons.note),
            Text(
              'Nota',
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
          IconButton(
            color: Colors.black,
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
    floatingActionButton: _currentIndex == 0
    ? Column(
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
            if (index == 3) {
              _showSettingsModal(context);
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
      ),
    );
  }
}

