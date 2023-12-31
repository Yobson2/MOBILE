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

import '../views/views_Connect/home_connect.dart';
import 'message_component.dart';

class CommentaireComponent extends StatefulWidget {
   final List<String>? allPhotos;
   final String? imageUrl;
   final String? infos;
   final String? placeAddress;
   final String? placeName;
   final double? latitude;
   final double? longitude;
  //  final String? cartegieItem;
  
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
   late final String cat;
  XFile? _imageFile;
 List<File> _images = [];

 bool testImage1=false;
 bool testImage2=false;
    
 
 

  int? userId;
  late final dynamic mesPhotos=mainSession.selectedImageUrl_;
  int nombreEtoiles = 0;
  late int locRegister ;
  late int id_entreprise;

  String? selectedCategory;
  String selectedOption = '';
  List<dynamic> searchResults = [];
  List<dynamic> searchResultsFinal = [];
  bool test=true;
  List<dynamic> resultat=[];
   bool printBtn = false;
    bool isDataValid = true;


 
  @override
  void initState() {
    super.initState();
     printBtn = false;
     commentLatitude=0;
     commentLongitude=0;
     locRegister = 0;
     id_entreprise=0;

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
  final id = mainSession.userId;
  setState(() {
    this.userId = id;
    testImage2 = true;
    commentLatitude = widget.latitude!;
    commentLongitude = widget.longitude!;
  }); 

      
  }

 
 Future<void> addCommentaire(int myId) async {
     if (
      (_commentaireController.text.isEmpty  
     || mainSession.categorie.isEmpty
    || texteAfficheAddresse.isEmpty 
    || nombreEtoiles == 0)  &&
    (mesPhotos== null  || _images.isEmpty) 
      
  ) {
    print("Remplissez tous les champs");
    setState(() {
       isDataValid=false;
    });
    return; // Arrêtez la fonction s'il manque des champs obligatoires
  }
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('${ApiManager().baseUrl}/addPost/$myId'),
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
   request.fields['id_localisation'] = locRegister.toString() ;
   request.fields['id_entreprise'] = id_entreprise.toString() ;
  request.fields['contenu_commentaire'] = _commentaireController.text;
  request.fields['nom_entreprise'] = _nameEntrepriseController.text ;
  request.fields['addresse_entreprise'] = texteAfficheAddresse;
  request.fields['nombre_etoiles'] = nombreEtoiles.toString();
  request.fields['longitude_'] = commentLongitude.toString();
  request.fields['latitude_'] = commentLatitude.toString();
  request.fields['categorie'] = mainSession.categorie;

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
       print("Success ok images $mesPhotos");
      setState(() {
         nombreEtoiles = 0;
        mainSession.selectedImageUrl_=[];
         testImage1=false;
         testImage2=false;
         texteAfficheAddresse = "Adresse du lieu";
         mainSession.categorie="";
         isDataValid=true;
        //  mesPhotos=null;
       
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
     
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => ConnectedUserWidget(token: "")),
      // );
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


 Future<void> getSuggestion() async {
    try {
       final requete = await ApiManager().fetchData("getItemsCommentaires", "message ok", "messageError");
      
       setState(() {
        searchResults = requete["data"];
      });
    } catch (e) {
      print("Erreur : Les données n'ont pas été recuperer $e");
    }
      
  }

   Future<void> _search() async {
      getSuggestion();
      String query = _nameEntrepriseController.text?? ''; 
      List<dynamic> filteredResults = [];
       
      
      if (query.isNotEmpty) {
        for (var item in searchResults) {
          if (item['nom_entreprise'] != null && item['nom_entreprise'].toLowerCase().contains(query)) {
            filteredResults.add(item);
          }
          
        } 
      }
        setState(() {
          searchResultsFinal=filteredResults;
         
        });


        
    }


  

  

  

  @override
  Widget build(BuildContext context) {

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
          InkWell(
          onTap: () {
            setState(() {
               printBtn = true;

            });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MapSample(testPrint: true,testPrint2:false)),
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
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(0.0)),
                ),
                child: Column(
                  children: [
                    if (testImage1 || testImage2)
                      Container(
                        color: testImage1 ? Colors.transparent : Colors.transparent,
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          // mesPhotos
                          itemCount: testImage1 ? _images.length : resultat.length ,
                          itemBuilder: (BuildContext context, int index) {
                            final imageUrl = testImage1 ? _images[index] : resultat[index];
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
               const ListTile(
          leading: Icon(Icons.info_outline, color: Colors.blue),
          title: Text(
            "Facultatif pour les particuliers",
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),


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
          //   setState(() {
          //   mainSession.setEntrepriseName(_nameEntrepriseController.text);
          // });
          _search();
          
          },
        ),
        if (searchResultsFinal.isNotEmpty) 
             Padding(
               padding: const EdgeInsets.only(right: 10.0,left: 10.0),
                child: Container(
                  // height: 150,
                   decoration: BoxDecoration(
                    
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child:ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchResultsFinal.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                           Row(
                            children: [
                               Text(searchResultsFinal[index]['nom_entreprise'],
                               style: const TextStyle(
                                    fontSize: 18, 
                                    color: Colors.black54
                                    
                                  ),
                               ),
                            ],
                           ),
                            
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                 const Icon(Icons.location_on, size: 14),
                              const SizedBox(width: 4),
                              Flexible(
                                
                                child: Text(
                                 searchResultsFinal[index]['adresse_entreprise']  ,
                                  softWrap: true, 
                                  style: const TextStyle(
                                    fontSize: 13, 
                                    
                                  ),
                                ),
                              ),
                              const SizedBox(width: 70,),
                               Text(
                               searchResultsFinal[index]['categories'],
                                style: TextStyle(
                                    fontSize: 10, 
                                    color: Colors.blue, 
                                    
                                  ),
                                
                                ),
                               
                              ],
                            ),
                          ],
                        )
                      ),
                      onTap: () {
                      
                        setState(() {
                         locRegister=searchResultsFinal[index]['id_localisation'];
                         id_entreprise=searchResultsFinal[index]['id_entreprise'];
                         _nameEntrepriseController.text=searchResultsFinal[index]['nom_entreprise'];
                         texteAfficheAddresse=searchResultsFinal[index]['adresse_entreprise'];
                         commentLongitude=searchResultsFinal[index]['longitude'];
                         commentLatitude=searchResultsFinal[index]['latitude'];
                         searchResultsFinal=[];
                      
                        });
                        },
                    );
                  },
                ), 
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
                              onTap: () async {
                                 resultat = await Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => GalleryPage()),
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
                child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: const Center(
                        child: Text(
                          "Ajouter une photo",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
              ),

            const Divider(),
            if (!isDataValid)
                          Container(
                            margin:EdgeInsets.only(left: 200),
                            child: const Text(
                              "Veuillez renseigner toutes les informations demandées",
                              style: TextStyle(color: Colors.red,fontSize: 10),
                            ),
                          ),
                      const SizedBox(height: 10),
             
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

