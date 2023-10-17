import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_notabene/main.dart';
import 'package:flutter_notabene/services/api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../gestion/session.dart';
import '../models/categories_model.dart';
import '../views/carte_view.dart';
import '../views/photo_view.dart';
import '../views/photos/galerie_photo.dart';

import 'package:http/http.dart' as http;

import 'message_component.dart';

class CommentaireComponent extends StatefulWidget {
   final List<String>? allPhotos;
   final String? imageUrl;
   final String? infos;
   final String? placeAddress;
   final String? placeName;
   final double? latitude;
   final double? longitude;
  
  const CommentaireComponent({Key? key, this.imageUrl,this.infos, this.placeAddress, this.placeName, this.latitude, this.longitude,this.allPhotos}) : super(key: key);
  
  
  

  @override
  _CommentaireComponentState createState() => _CommentaireComponentState();
}


class _CommentaireComponentState extends State<CommentaireComponent> {
  bool isLoading = true;
  final TextEditingController _commentaireController = TextEditingController();
  final TextEditingController _nameEntrepriseController = TextEditingController();
   String texteAfficheLieu = "Structure ou Lieu"; 
   String texteAfficheAddresse = "Adresse du lieu"; 

  late double commentLatitude;
  late double commentLongitude; 
   late final String? image;
   final picker = ImagePicker();
  XFile? _imageFile;
 List<File> _images = [];

 bool testImage1=false;
 bool testImage2=false;
    
 
 

  int? userId;
  late final dynamic mesPhotos=mainSession.selectedImageUrl_;
  int nombreEtoiles = 0;

  String? selectedCategory;
  String selectedOption = '';


 
  @override
  void initState() {
    super.initState();
      if (widget.placeName != null && widget.placeAddress != null) {
      texteAfficheLieu = widget.placeName!;
      texteAfficheAddresse = widget.placeAddress!;
    }
     _fetchAndDisplayUserId();
    
  }
  
  
  

  Future<void> _pickImages() async {
    List<XFile> images = await ImagePicker().pickMultiImage();
    if (images != null) {
      setState(() {
        _images = images.map((XFile file) => File(file.path)).toList();
        testImage1=true;
        testImage2=false;
      });
    }
  }
 
  
  Future<void> _fetchAndDisplayUserId() async {
    final id= mainSession.userId;
   
     setState(() {
       this.userId = id;
       testImage2=true;
       commentLatitude=widget.latitude!;
       commentLongitude=widget.longitude!;
     }); 
      
  }

 
 Future<void> addCommentaire(int myId) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('http://192.168.1.8:8082/apiNotabene/v1/addPost/$myId'),
  );

  if (_images.isNotEmpty) {
    for (var imageFile in _images) {
      var multipartFile = await http.MultipartFile.fromPath('images', imageFile.path);
      request.files.add(multipartFile);
    }
  }

  if (mesPhotos != null && mesPhotos.isNotEmpty) {
    for (var imagePath in mesPhotos) {
      var multipartFile = await http.MultipartFile.fromPath('images', imagePath);
      request.files.add(multipartFile);
    }
  }

  request.fields['contenu_commentaire'] = _commentaireController.text;
  request.fields['nom_entreprise'] = _nameEntrepriseController.text ;
  request.fields['addresse_entreprise'] = texteAfficheAddresse;
  request.fields['nombre_etoiles'] = nombreEtoiles.toString();
  request.fields['longitude_'] = commentLongitude.toString();
  request.fields['latitude_'] = commentLatitude.toString();
  request.fields['categorie'] = selectedCategory.toString();

  try {
      // Afficher le loader
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
    barrierDismissible: false, // L'utilisateur ne peut pas fermer la boîte de dialogue
  );
    var response = await request.send();
    if (response.statusCode == 200) {
    
      print('Images envoyées avec succès');
       _commentaireController.clear();
       _nameEntrepriseController.clear();
      setState(() {
         nombreEtoiles = 0;
        //  mesPhotos=null;
        mainSession.selectedImageUrl_=[];
        mainSession.entreprise="";
        mainSession.motCommentaire="";
         testImage1=false;
         testImage2=false;
         texteAfficheAddresse = "Adresse du lieu";
       
      });

      // Fermer le loader
      Navigator.of(context, rootNavigator: true).pop();
       showDialog(
        context: context,
        builder: (BuildContext context) {
          return SuccessModal();
        },
      );
      

      Timer(const Duration(seconds: 1), () {
        Navigator.of(context).pop(); 
      });
    } else {
      print('Erreur lors de l\'envoi des images. Statut ${response.statusCode}');
      // Fermer le loader
      Navigator.of(context, rootNavigator: true).pop();
    }
  } catch (e) {
    print("Erreur lors de l'envoi des images: $e");
    // Fermer le loader
    Navigator.of(context, rootNavigator: true).pop();
  }
}

  

  

  @override
  Widget build(BuildContext context) {
    print('User $userId created ');
      // _nameEntrepriseController.text = mainSession.entreprise;
      // _commentaireController.text = mainSession.motCommentaire;

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
          title: const Text('Ajoutez un avis '), 
          backgroundColor: Colors.grey,
           elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          
          child: 
          ListView( 
            children: <Widget>[
            const Divider(),
           TextField(
             textDirection: TextDirection.ltr,
             enabled: true,
          controller: _nameEntrepriseController,
          decoration: const InputDecoration(
            labelText: "Entreprise",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.comment),
          ),
          onChanged: (value) {
            setState(() {
            mainSession.setEntrepriseName(_nameEntrepriseController.text);
          });
          },
        ),
          const Divider(),
          InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MapSample()),
            );
          },
          child: Container(
            padding: EdgeInsets.all(10.0), 
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              children: [
                const Icon(Icons.place),
                const SizedBox(width: 8.0),
                Text(texteAfficheAddresse),
                const Spacer(), 
                const Icon(Icons.map),
              ],
            ),
          ),
        ),
        const Divider(),
        TextField(
          controller: _commentaireController,
          textDirection: TextDirection.ltr,
          maxLines: 5,
          decoration: const InputDecoration(
            labelText: "Votre commentaire",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.comment),
          ),
          onChanged: (value) {
             setState(() {
            mainSession.setCommentaire(_commentaireController.text);
          });
          },
        ),
         const Divider(),
              Row(
                
                mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      nombreEtoiles = index + 1; 
                    });
                  },
                  child: Icon(
                    index < nombreEtoiles ? Icons.star : Icons.star_border,
                    color: Colors.yellow,
                    size: 30.0,
                  ),
                );
              }),
            ),
  
              const Divider(),
              Column(
              children: [
                const Text(
                  'Choisissez une catégorie',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButton<String>(
                  value: selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue;
                    });
                  },
                  items: CategoriesData.categories.map((Category category) {
                    return DropdownMenuItem<String>(
                      value: category.title,
                      child: Row(
                        children: <Widget>[
                          Icon(category.icon, color: category.color),
                          const SizedBox(width: 10.0),
                          Text(category.title),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
               const Divider(),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(0.0)),
                ),
                child: Column(
                  children: [
                    if (testImage1 || testImage2)
                      Container(
                        color: testImage1 ? Colors.orange : Colors.red,
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: testImage1 ? _images.length : mesPhotos?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            final imageUrl = testImage1 ? _images[index] : mesPhotos![index];
                            return Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (testImage1) {
                                    _showImageModal(imageUrl.path); 
                                  } else {
                                    _showImageModal(imageUrl);
                                  }
                                },
                                child: Container(
                                  width: 150,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    image: DecorationImage(
                                      image: testImage1
                                          ? FileImage(_images[index])
                                          : FileImage(File(imageUrl)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
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
                                Navigator.pop(context); 
                                Navigator.pop(context); 
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const GalleryPage()),
                                );
                                setState(() {
                                   testImage2=true;
                                   testImage1=false;
                                });
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.photo),
                              title: Text("Galerie du téléphone"),
                              onTap: () {
                               _pickImages();
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
                    addCommentaire(userId!);
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
            ),
           
            ],
          ),
        ),
        
      ),
    );
  }
 


void _showImageModal(String imageUrl) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        
        child: Container(
          width: 800,
          height: 400,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(File(imageUrl)),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}


}

