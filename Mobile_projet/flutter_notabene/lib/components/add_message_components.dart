import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_notabene/views/photo_view.dart';
import 'package:flutter_notabene/views/photos/galerie_photo.dart';
import 'package:flutter_notabene/views/photos/galerie_tel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../services/connectEtat.dart';

class AddCommentaireComponent extends StatelessWidget {
 
  final TextEditingController _nomStructureController = TextEditingController();
  final TextEditingController _commentaireController = TextEditingController();
  final TextEditingController _etoilesController = TextEditingController();

  
  //  AddCommentaireComponent({Key? key});
  Future<void> addCommentaire(myId) async {
 
  final userData = {
    "contenu_commentaire": _commentaireController.text,
    "nom_entreprise": _nomStructureController.text,
    "nombre_etoiles":_etoilesController.text,
    "photo": "bfgbebgb",
  };

  
  final url = Uri.parse("http://192.168.1.5:8082/apiNotabene/v1/addPost/$myId");

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

     final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.getUserIdFromStorage(); 

    // Maintenant vous pouvez accéder à l'ID
    final userId = userProvider.userId;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.all(16.0),
        child: Wrap(
          children: <Widget>[
                 const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Ajoutez un commentaire ",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
              const SizedBox(height: 5,),
               Container(
                      width: 300,
                      child: TextField(
                        controller: _nomStructureController,
                        decoration: const InputDecoration(
                          labelText: "Nom de la structure  ",
                           border: OutlineInputBorder(),
                        ),
                      ),
                ),
                 const SizedBox(height: 5),
                Container(
                      width: 300,
                      child: TextField(
                        controller: _commentaireController,
                         maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: "Votre commentaire",
                           border: OutlineInputBorder(),
                        ),
                      ),
                ),
                const SizedBox(height: 5),
                Container(
                      width: 100,
                      child: TextField(
                      maxLines: 1, 
                      maxLength: 1, 
                        controller: _etoilesController,
                        decoration: const InputDecoration(
                          labelText: "Etoiles ",
                           border: OutlineInputBorder(),
                        ),
                      ),
                ),
                ]
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showPhotoBottomSheet(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: const Text("Ajouter une photo "),
                ),
                Container(
                  height: 80,
                  width: 80,
                  decoration:const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  child: Column(
                    children: [
                      Image.asset("assets/images/pict2.jpg"),
                    ]
                    
                    ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Mydata(),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PhotoViewWithHero()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_album),
              title: Text("Galerie de notabene"),
              onTap: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GalleryPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text("Galerie du telephone"),
              onTap: () {
                // _pickImageFromGallery();
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyImagePicker()),
                );
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



class Mydata extends StatelessWidget {
  const Mydata({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        height: 50,
        color: Colors.amber,
        child: Text('Build'),
        ),
      );
  }
}