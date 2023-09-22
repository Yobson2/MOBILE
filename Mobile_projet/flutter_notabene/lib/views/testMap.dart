import 'package:flutter/material.dart';

class SelectedPhotosPage extends StatelessWidget {
  final List<String> allPhotos;

  SelectedPhotosPage(this.allPhotos);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photos Sélectionnées'),
      ),
      body: ListView.builder(
        scrollDirection: Axis.horizontal, // Permet de faire défiler horizontalement
        itemCount: allPhotos.length,
        itemBuilder: (context, index) {
          final imageUrl = allPhotos[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 150, // Définissez la largeur de chaque image selon vos préférences
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
