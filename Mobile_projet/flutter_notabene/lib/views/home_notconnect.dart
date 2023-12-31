
import 'package:flutter/material.dart';
import 'package:flutter_notabene/screens/login_screen.dart';
import 'package:flutter_notabene/views/photo_view.dart';

import '../screens/Inscrire/testConnexion.dart';
import '../screens/Inscrire/testResgiste.dart';
import 'carte_view.dart';
import 'home_view.dart';



class NotConnectedUserWidget extends StatefulWidget {
  const NotConnectedUserWidget({Key? key}) : super(key: key);

  @override
  State<NotConnectedUserWidget> createState() => _NotConnectedUserWidgetState();
}

class _NotConnectedUserWidgetState extends State<NotConnectedUserWidget> {
  int _currentIndex = 0; 
   bool printBtn = true;

   List<Widget> pages = [
    const HomeView(),
    const MapSample(),
    const PhotoViewWithHero(),
    // const MessageConnexion(),
    
    
  ];

 
  @override
  void initState() {
    super.initState();
     printBtn = true;
  } 

  //dispose() est utilisé pour libérer les ressources lorsque
  // le widget n'est plus nécessaire, afin d'éviter des problèmes
  // de mémoire et de comportement indésirable.
  @override
  void dispose() {
    super.dispose();
  }

  
 


  @override
  Widget build(BuildContext context) {
     pages[1] = MapSample(testPrint: printBtn);
    return Scaffold(
      
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0), 
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
            title: const Row(
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
          IconButton(
            color: Colors.black,
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginForm()),
              );
            },
          ),
        ],
    
            centerTitle: true,
          ),
        ),
      body:IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      
      floatingActionButton:  const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // AddCommentaireComponent(),
      //     SizedBox(height: 5), 
      //     AddDestinationMapComponent()
        ],
      ),
      
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index == 1) {
              printBtn=false;
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




// class MessageConnexion extends StatelessWidget {
//   const MessageConnexion({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Colors.blue,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(
//               Icons.error,
//               color: Colors.white,
//               size: 40,
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               "Vous n'êtes pas connecté",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               "Pour accéder à cette fonctionnalité, veuillez vous connecter avec votre compte. Si vous n'avez pas encore de compte, vous pouvez en créer un en quelques étapes simples. Connectez-vous dès maintenant pour profiter de l'expérience complète de notre application !",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                  Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const LoginForm()),
//                 );
//               },
//               child: const Text("Se connecter"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



