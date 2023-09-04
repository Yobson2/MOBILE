
import 'package:flutter/material.dart';
import 'package:flutter_notabene/components/add_message_components.dart';
import 'package:flutter_notabene/screens/login_screen.dart';
// import 'package:flutter_notabene/views/carte_view.dart';
// import 'package:flutter_notabene/views/home_view.dart';
// import 'package:flutter_notabene/views/photo_view.dart';


class NotConnectedUserWidget extends StatefulWidget {
  const NotConnectedUserWidget({Key? key}) : super(key: key);

  @override
  State<NotConnectedUserWidget> createState() => _NotConnectedUserWidgetState();
}

class _NotConnectedUserWidgetState extends State<NotConnectedUserWidget> {
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
    shape: RoundedRectangleBorder(
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
            Text(
              'Paramètres',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Profil'),
              onTap: () {
                // Mettez ici la logique pour l'option 1
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.notification_add),
              title: Text('Notifications'),
              onTap: () {
                // Mettez ici la logique pour l'option 2
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Quitter'),
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
            icon: Icon(Icons.person_outline),
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
          // CarteGloblale(),
          // PhotoViewWithHero(),
          // // HomeView(),
          Center(child: Text("Non connecté"))
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
