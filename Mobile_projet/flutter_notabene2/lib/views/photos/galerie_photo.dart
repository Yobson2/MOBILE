import 'package:flutter/material.dart';

class DetailPhotoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'photoHero', // Utilisation de la même balise pour la transition
          child: Container(
            color: Colors.blue,
            child: Text('Détail de la photo'),
          ),
        ),
      ),
    );
  }
}