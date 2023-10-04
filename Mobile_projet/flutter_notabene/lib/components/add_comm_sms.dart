import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_notabene/main.dart';
import 'package:flutter_notabene/services/api_service.dart';
import 'package:image_picker/image_picker.dart';
import '../views/carte_view.dart';
import '../views/photo_view.dart';
import '../views/photos/galerie_photo.dart';

import 'package:http/http.dart' as http;

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
   String texteAfficheLieu = "Structure ou Lieu"; 
   String texteAfficheAddresse = "Adresse du lieu"; 

  late double commentLatitude;
  late double commentLongitude; 
   late final String? image;
   final picker = ImagePicker();
  XFile? _imageFile;
  int? userId;
  late final dynamic mesPhotos;
  
   int nombreEtoiles = 0;


 
  @override
  void initState() {
    super.initState();
      if (widget.placeName != null && widget.placeAddress != null) {
      texteAfficheLieu = widget.placeName!;
      texteAfficheAddresse = widget.placeAddress!;
    }
     _fetchAndDisplayUserId();
    
  }
  
  Future<void> _fetchAndDisplayUserId() async {
    final id= mainSession.userId;
    final data=mainSession.selectedImageUrl_;
   
     setState(() {
       this.userId = id;
       this.mesPhotos = data;
       commentLatitude=widget.latitude!;
       commentLongitude=widget.longitude!;
     }); 
      
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = pickedFile;
    });
    print(_imageFile!.path);
  }

 

  Future<void> addCommentaire(myId) async {
    final comm={
      "contenu_commentaire":_commentaireController.text,
      "nom_entreprise":texteAfficheLieu,
      "addresse_entreprise":texteAfficheAddresse,
      "nombre_etoiles":nombreEtoiles,
      "photo_":mesPhotos,
      "longitude_":commentLongitude,
      "latitude_":commentLatitude
    };
 

     try {
        await ApiManager().postData("addPost/$myId", comm, "message ook", "messageError ok");
      
     } catch (e) {
        print("object not found");
     }
  
  }
  

  

  @override
  Widget build(BuildContext context) {
    print('User $userId created ');
    print(" ddadaddaadadd   $mesPhotos");

    
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
          
          child: 
          ListView( 
            children: <Widget>[
            const Divider(),
           InkWell(
          onTap: () {
            Navigator.push(
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
                const Icon(Icons.business),
                const SizedBox(width: 8.0),
                Text(texteAfficheLieu),
                const Spacer(), 
                const Icon(Icons.map),
              ],
            ),
          ),
        ),
          const Divider(),
          InkWell(
          onTap: () {
            Navigator.push(
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
          maxLines: 5,
          decoration: const InputDecoration(
            labelText: "Votre commentaire",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.comment),
          ),
          onChanged: (value) {},
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
                  decoration:const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(0.0))
                  ),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.black12,
                        height: 200,
                        child: ListView.builder(
                    scrollDirection: Axis.horizontal, 
                    itemCount: mesPhotos?.length ?? 0,
                    itemBuilder: (context, index) {
                      if (mesPhotos != null && mesPhotos!.isNotEmpty) {
                         
                      final imageUrl = mesPhotos![index];
                      return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: GestureDetector(
                          onTap: () {
                            _showImageModal(imageUrl);
                          },
                          child: Container(
                          width: 150,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            image: DecorationImage(
                              image: FileImage(File(imageUrl)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        )
                      );
                      }else {
                      return const Text("Aucune image disponible");
                    }
                },  
                         ),
                      ),
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
            ),
           
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

