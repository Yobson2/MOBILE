import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../services/connectEtat.dart';

class AddCommentaireComponent extends StatelessWidget {
 
  final TextEditingController _nomStructureController = TextEditingController();
  final TextEditingController _commentaireController = TextEditingController();
  final TextEditingController _etoilesController = TextEditingController();
  
  //  const AddCommentaireComponent({Key? key});
  Future<void> addCommentaire(myId) async {
 
  final userData = {
    "contenu_commentaire": _commentaireController.text,
    "nom_entreprise": _nomStructureController,
    "nombre_etoiles":_etoilesController.text,
    "photo": "bfgbebgb",
  };

  
  final url = Uri.parse("http://192.168.120.248:8082/apiNotabene/v1/addPost/$myId");

  var response = await http.post(
    url,
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode(userData),
  );

  if (response.statusCode == 200) {
     _nomStructureController.clear();
     _commentaireController.clear();
     _etoilesController.clear();
   
     print("Commentaire envoyée");
  } else {
    // En cas d'erreur, affichez un message d'erreur
    print("Erreur photoCommentUser: ${response.statusCode}");
  }

  print("test $myId");
  print(userData);

}
  
  // Méthode pour afficher le modal des commentaires
  void _modal(BuildContext context) {
     final userId = Provider.of<UserProvider>(context, listen: false).userId;

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
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
              SizedBox(height: 5,),
               Container(
                      width: 300,
                      child: TextField(
                        controller: _nomStructureController,
                        decoration: InputDecoration(
                          labelText: "Nom de la structure ",
                           border: OutlineInputBorder(),
                        ),
                      ),
                ),
                 SizedBox(height: 5),
                Container(
                      width: 300,
                      child: TextField(
                        controller: _commentaireController,
                         maxLines: 5,
                        decoration: InputDecoration(
                          labelText: "Votre commentaire",
                           border: OutlineInputBorder(),
                        ),
                      ),
                ),
                 SizedBox(height: 5),
                Container(
                      width: 100,
                      child: TextField(
                      maxLines: 1, 
                      maxLength: 1, 
                        controller: _etoilesController,
                        decoration: InputDecoration(
                          labelText: "Etoiles ",
                           border: OutlineInputBorder(),
                        ),
                      ),
                ),
                ]
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
                    onPressed: () {
                    addCommentaire(userId);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    child: Text("Ajouter".toUpperCase()),
                  ),
                ],
              ),
            ),
          ]
      )
      )
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
