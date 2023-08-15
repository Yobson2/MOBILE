
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../camera_screen.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final CameraDescription? camera; // Utilisez le point d'interrogation pour le rendre optionnel

  const MyHomePage({Key? key, required this.title, this.camera})
      : super(key: key);

   @override
  State<MyHomePage> createState() => _MyHomePageState();

  // ...
}


class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Autres widgets de votre page d'accueil
            const Text('Bienvenue sur la page d\'accueil'),
            ElevatedButton(
                  onPressed: () {
                    if (widget.camera != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CameraScreen(camera: widget.camera!)),
                      );
                    } else {
                      // Gérez le cas où la caméra n'est pas disponible
                    }
                  },
                  child: Text('Ouvrir la caméra'),
                ),


          ],
        ),
      ),
    );
  }
}
