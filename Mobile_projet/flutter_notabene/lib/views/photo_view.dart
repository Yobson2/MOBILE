import 'package:flutter/material.dart';
import 'package:flutter_notabene/views/photos/galerie_photo.dart';
import 'package:flutter_notabene/views/photos/print_camera.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/infosConnexion.dart';
import '../main.dart';

class PhotoViewWithHero extends StatelessWidget {
  const PhotoViewWithHero({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = mainSession.userId!= 0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.blue, Colors.lightBlue],
                  center: Alignment.center,
                  focal: Alignment.center,
                  radius: 0.8,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                border: Border.all(
                  color: Colors.blue.shade800,
                  width: 3,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      isLoggedIn ?
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PrintCamera()),
                      ):  ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Vous n'êtes pas connecté !"),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.blue,
                        ),
                      );
                      return;
                    
                    },
                    icon: const Icon(
                      Icons.camera_alt,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                 isLoggedIn ?
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GalleryPage()),
                ):  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Vous n'êtes pas connecté !"),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.blue,
                  ),
                );
                return;
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                textStyle: GoogleFonts.dangrek(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    // decoration: TextDecoration.underline,
                  ),
                ),
                side: const BorderSide(color: Colors.white, width: 2),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.photo_library,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Galerie',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}


