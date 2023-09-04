import 'package:flutter/material.dart';

class AddCommentaireComponent extends StatelessWidget {
  const AddCommentaireComponent({Key? key});

  // Méthode pour afficher le modal des commentaires
  void _modal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.all(16.0),
        child: Wrap(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Ajoutez un commentaire",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Nom de la structure",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: "Votre commentaire",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    maxLines: 1, 
                    maxLength: 1, 
                    decoration: InputDecoration(
                      labelText: "Etoiles",
                      border: OutlineInputBorder(),
                    ),
                    
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Ouvrir la feuille de bas de page pour ajouter des photos ici
                _showPhotoBottomSheet(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: Text("Ajouter une photo"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child: Text("Annuler".toUpperCase()),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    child: Text("Ajouter".toUpperCase()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Méthode pour afficher la feuille de bas de page des photos
  void _showPhotoBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.camera),
              title: Text("Prendre une photo"),
              onTap: () {
                // Gérer la logique pour prendre une photo ici
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text("Sélectionner une photo depuis la galerie"),
              onTap: () {
                // Gérer la logique pour sélectionner une photo depuis la galerie ici
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.comment_bank),
      onPressed: () {
        _modal(context);
      },
    );
  }
}
