import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import '../services/connectEtat.dart';
import '../views/photo_view.dart';
import '../views/photos/galerie_photo.dart';
import '../views/photos/galerie_tel.dart';
import 'package:http/http.dart' as http;

class CommentaireComponent extends StatefulWidget {
   final String? imageUrl;
  const CommentaireComponent({Key? key, this.imageUrl,}) : super(key: key);
  
  
  

  @override
  _CommentaireComponentState createState() => _CommentaireComponentState();
}


class _CommentaireComponentState extends State<CommentaireComponent> {
  bool isLoading = true;
  final TextEditingController _nomStructureController = TextEditingController();
  final TextEditingController _commentaireController = TextEditingController();
  final TextEditingController _etoilesController = TextEditingController();

  late double commentLatitude;
  late double commentLongitude ;
   late final String? image;

  @override
  void initState() {
    super.initState();
  }


Future<void> searchPlaces(String query) async {
  final apiKey = 'AIzaSyCRD-FSgdo6Tcpoj-RTuLQfmERxBagzm04';
  final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&key=$apiKey');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final Map<String, dynamic> location = data['results'][0]['geometry']['location'];
    double latitude = location['lat'];
    double longitude = location['lng'];

    setState(() {
    commentLatitude = latitude;
    commentLongitude = longitude;
  });
  } else {
    throw Exception('Erreur lors de la recherche d\'endroits');
  }
}

  Future<void> addCommentaire(myId) async {
     
     final query = _nomStructureController.text;
    searchPlaces(query);
  //    final data = {
  //   "contenu_commentaire": _commentaireController.text,
  //   "nom_entreprise": _nomStructureController.text,
  //   "nombre_etoiles":_etoilesController.text,
  //   "photo":  widget.imageUrl,
  //   "Latitude":commentLatitude,
  //   "Longitude":commentLongitude
    
  // };

  
  final url = Uri.parse("http://192.168.1.10:8082/apiNotabene/v1/addPost/$myId");
  var request = http.MultipartRequest('POST', url);
  // var response = await http.post(
  //   url,
  //   headers: {
  //     "Content-Type": "application/json",
  //   },
  //   body: jsonEncode(data),
  // );
  // request.fields['contenu_commentaire'] = _commentaireController.text.toString();
  // request.fields['nom_entreprise'] = _nomStructureController.text.toString();
  // request.fields['nombre_etoiles'] = _etoilesController.text;
  // request.fields['Latitude'] = commentLatitude.toString();
  // request.fields['Longitude'] = commentLongitude.toString();
    var image = await http.MultipartFile.fromString("image", widget.imageUrl!);
    request.files.add(image);

  try {
    var response = await request.send();
    if (response.statusCode == 200) {
     _nomStructureController.clear();
     _commentaireController.clear();
     _etoilesController.clear();
   
     print("Commentaire envoyée");
  } else {
    print("Erreur photoCommentUser: ${response.statusCode}");
  }
  
  } catch (e) {
    print('Erreur lors de l\'envoi du commentaire: $e');
  }
  }

  

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userId = userProvider.userId;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold( 
        appBar: AppBar( 
          leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
          title: const Text('Ajoutez un commentaire'), 
          backgroundColor: Colors.grey,
           elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView( 
            children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      const Icon(Icons.favorite, color: Colors.red),
                      const SizedBox(width: 10),
                      Text(
                        "Lieux préférés ",
                        style: TextStyle(color: Colors.grey[700], fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () { 
                 
                },
                child: const Row(
                  children: [
                    Icon(Icons.map, color: Colors.white),
                    SizedBox(width: 5),
                    Text("Carte", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),


               const Divider(),
              TextField(
                controller: _nomStructureController,
                decoration: const InputDecoration(
                  labelText: "Nom de la structure",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.business),
                ),
              ),
              const Divider(),
              TextField(
                controller: _commentaireController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: "Votre commentaire",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.comment),
                ),
              ),
              const Divider(),
              TextField(
                maxLines: 1, 
                maxLength: 1, 
                controller: _etoilesController,
                decoration: const InputDecoration(
                  labelText: "Etoiles",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.star),
                ),
              ),
              const Divider(),
               Container(
                  decoration:const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  child: Column(
                    children: [
                      widget.imageUrl != null 
                      ? Image.file(File(widget.imageUrl!))  
                      : Text('Aucune image sélectionnée'),
                    ] 
                    ),
                ),
               const Divider(),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
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
                              title: Text("Galerie du téléphone"),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MyImagePicker()),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: const Text("Ajouter une photo"),
              ),

            const Divider(),
             
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), 
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Icon(Icons.clear, color: Colors.white), 
                        SizedBox(width: 8),
                        Text('Annuler', style: TextStyle(color: Colors.white)), 
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    addCommentaire(userId);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), 
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        
                        Icon(Icons.check, color: Colors.white), 
                        SizedBox(width: 8), 
                        Text('Valider', style: TextStyle(color: Colors.white)), // Texte
                      ],
                    ),
                  ),
                ),
              ],
            )

            ],
          ),
        ),
        
      ),
    );
  }
}

