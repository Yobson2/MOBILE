import 'package:flutter/material.dart';
import 'package:flutter_notabene/components/add_destinationMap_component.dart';
import 'package:flutter_notabene/components/add_message_components.dart';
import 'package:flutter_notabene/views/carte_view.dart';
import 'package:flutter_notabene/views/home_view.dart';
// import 'package:flutter_notabene/views/parametres_view.dart';
import 'package:flutter_notabene/views/photo_view.dart';
import 'package:flutter_notabene/views/sectionBlocs/details_items.dart';
// import 'package:flutter_notabene/views/sectionBlocs/listes_sections.dart';


class HomeScreem extends StatefulWidget {
  const HomeScreem({Key? key}) : super(key: key);

  @override
  State<HomeScreem> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreem> {
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

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
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
              // Action du bouton de notifications
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => NotificationsPage()),
              // );
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
          HomeView(),
          CarteView(),
          PhotoView(),
          // ParamsView(),
          // ListesBlocItems(),
          MyDetailsItems()
        ],
      ),
      //boutton floating
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AddCommentaireComponent(),
          SizedBox(height: 5), // Espacement entre les boutons flottants
          AddDestinationMapComponent()
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
