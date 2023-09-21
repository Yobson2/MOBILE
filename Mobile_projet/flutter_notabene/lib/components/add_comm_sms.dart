import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_notabene/views/sectionBlocs/details_items.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart'; 
import '../services/connectEtat.dart';
import '../views/carte_view.dart';
import '../views/photo_view.dart';
import '../views/photos/galerie_photo.dart';
import '../views/photos/galerie_tel.dart';
import 'package:http/http.dart' as http;

class CommentaireComponent extends StatefulWidget {
   final String? imageUrl;
   final String? infos;
  const CommentaireComponent({Key? key, this.imageUrl,this.infos}) : super(key: key);
  
  
  

  @override
  _CommentaireComponentState createState() => _CommentaireComponentState();
}


class _CommentaireComponentState extends State<CommentaireComponent> {
  bool isLoading = true;
  final TextEditingController _nomStructureController = TextEditingController();
  final TextEditingController _commentaireController = TextEditingController();
  final TextEditingController _etoilesController = TextEditingController();

  late double commentLatitude;
  late double commentLongitude; 
   late final String? image;
   final picker = ImagePicker();
  XFile? _imageFile;
  


  @override
  void initState() {
    super.initState();
      if (widget.infos != null) {
      _nomStructureController.text = widget.infos!;
    }
  }
  

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = pickedFile;
    });
    print(_imageFile!.path);
  }


Future<void> searchPlaces(String query) async {
  final apiKey = 'AIzaSyCRD-FSgdo6Tcpoj-RTuLQfmERxBagzm04';
  // String apiUrl = dotenv.get('API_URL');;
  
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
  
  final url = Uri.parse("http://192.168.1.7:8082/apiNotabene/v1/addPost/$myId");
  var request = http.MultipartRequest('POST', url);
  request.fields['contenu_commentaire'] = _commentaireController.text.toString();
  request.fields['nom_entreprise'] = _nomStructureController.text.toString();
  request.fields['nombre_etoiles'] = _etoilesController.text;
  request.fields['latitude'] = commentLatitude.toString();
  request.fields['longitude'] = commentLongitude.toString();
    //  var image = await http.MultipartFile.fromPath("image", widget.imageUrl!);
    // request.files.add(image);
    if (widget.imageUrl != null) {
    var image = await http.MultipartFile.fromPath("image", widget.imageUrl!);
    request.files.add(image);
  } else {
    print("widget.imageUrl est null");
    return;
  }

  try {
    var response = await request.send();
    if (response.statusCode == 201) {
     _nomStructureController.clear();
     _commentaireController.clear();
     _etoilesController.clear();
   
     print("Commentaire envoyée");
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Le formulaire a été soumis avec succès!'),
        ),
      );
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
          title: const Text('Ajoutez un commentaire '), 
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
            ],
          ),


               const Divider(),
             TextField(
                controller: _nomStructureController,
                decoration: InputDecoration(
                  labelText: "Structure ou Lieu",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.business),
                  suffixIcon: InkWell(
                    onTap: () {
                      print("Clic sur l'icône de suffixe");
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MapSample()),
                        );
                    },
                    child:  const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.map),
                        SizedBox(width: 8.0),
                        Text("Carte"),
                      ],
                    ),
                  ),
                ),
                onChanged: (value) {
                  // bool isValid = RegExp(r'^[A-Za-z\s]+$').hasMatch(value);
                  // if (!isValid) {

                  // }
                },
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
                onChanged: (value) {
                // bool isValid = RegExp(r'^[A-Za-z\s]+$').hasMatch(value);
                // if (!isValid) {
                //   //// ////
                // }
              },
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
                      // _imageFile.path
                      widget.imageUrl != null 
                      ? afficherImage( widget.imageUrl!) 
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
                                _pickImageFromGallery();
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
  Widget afficherImage(String url) {
  if (url.startsWith('http') ) {
    return Image.network(url);
   }
  // else if (url.startsWith('/data')) {
  //   return Image.file(File(url));
  // } 
  else if (File(url).existsSync() ) {
    return Image.file(File(url));
  }
   else {
    return Text('Erreur: Format d\'image non pris en charge');
  }
}

}

