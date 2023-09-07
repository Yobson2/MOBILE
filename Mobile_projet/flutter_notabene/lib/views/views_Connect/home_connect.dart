

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_notabene/components/add_message_components.dart';
import 'package:flutter_notabene/screens/login_screen.dart';
import 'package:flutter_notabene/views/carte_view.dart';
import 'package:flutter_notabene/views/home_view.dart';
import 'package:flutter_notabene/views/photo_view.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/connectEtat.dart';


class ConnectedUserWidget extends StatefulWidget {
    final String token;
  const ConnectedUserWidget({required this.token, Key? key}) : super(key: key);

  @override
  State<ConnectedUserWidget> createState() => _ConnectedUserWidgetState();
}

class _ConnectedUserWidgetState extends State<ConnectedUserWidget> {
  late String email;

   Map<String, dynamic> userData = {};
  late PageController _pageController;
  int _currentIndex = 0; // Initialize the current index to 0

  //initState() est utilisé pour les initialisations 
  //nécessaires lors de l'ajout du widget à l'interface utilisateur
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentIndex,
    );


    try {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

      // Extrayez les valeurs du token
      email = jwtDecodedToken['adresse_email'];

      fetchUserData();
    } catch (e) {
      print('Erreur lors du décodage du token : $e');
    }
  } 


  Future<void> fetchUserData() async {
    try {
      // Effectuez une requête HTTP pour récupérer les données de l'utilisateur en fonction de son email
      final response = await http.get(Uri.parse('http://192.168.1.17:8082/apiNotabene/v1/userByEmail/$email'));

      if (response.statusCode == 200) {
        userData = json.decode(response.body);

        // Mettez à jour l'interface utilisateur avec les données de l'utilisateur
        setState(() {});

        // Enregistrez l'ID de l'utilisateur dans le stockage local
        final prefs = await SharedPreferences.getInstance();
        prefs.setInt('user_id', userData['users']['id_utilisateur']);

        // Utilisez le Provider pour définir l'ID de l'utilisateur
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userData['users']['id_utilisateur']);

        print('Données de l\'utilisateur : $userData');
      } else {
        // Gérez les erreurs de requête HTTP
        print('Erreur lors de la récupération des données de l\'utilisateur. Code de réponse : ${response.statusCode}');
      }
    } catch (e) {
      // Gérez les erreurs de requête HTTP
      print('Erreur lors de la récupération des données de l\'utilisateur : $e');
    }
  }


  //dispose() est utilisé pour libérer les ressources lorsque
  // le widget n'est plus nécessaire, afin d'éviter des problèmes
  // de mémoire et de comportement indésirable.
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
        padding: EdgeInsets.all(30.0),
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
                // Mettez ici la logique pour l'option 1
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.notification_add),
              title: const Text('Notifications'),
              onTap: () {
                // Mettez ici la logique pour l'option 2
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Quitter'),
              onTap: () {
                // Mettez ici la logique pour l'option 2
                Navigator.pop(context);
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
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        controller: _pageController,
        children: const <Widget>[
          // HomeView(),
          CarteGloblale(),
          PhotoViewWithHero(),
          // HomeView(),
           Text("Bienvenue,"),
        ],
      ),
      //boutton floating
      floatingActionButton:  Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AddCommentaireComponent(),
      //     SizedBox(height: 5), 
      //     AddDestinationMapComponent()
        ],
      ),
      
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            // Afficher le modal des paramètres lorsque l'élément "Paramètres" est cliqué
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
                label: "carte",
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
