import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_notabene/components/add_comm_sms.dart';
import 'package:flutter_notabene/main.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  bool _isLoading = true;
  List<dynamic> _photos = [];
  int? _userId;
  List<String> _selectedImageUrls = [];
  List<int> imageIdsToDelete = [];

  Future<void> _getData(id) async {
    final result = await _someAsyncMethod(id);
    setState(() {
      _photos = result;
      _isLoading = false;
    });
  }

 Future<List<dynamic>> _someAsyncMethod(id) async {
  final response = await database.getUserImages(id);
  // Créer une nouvelle liste modifiable à partir de la liste existante
      List<dynamic> mutableList = List.from(response);
      return mutableList;
    }

  void _onPhotoClicked(List<dynamic> resultatImage) {
    setState(() {
      if (_selectedImageUrls.contains(resultatImage[0]) && imageIdsToDelete.contains(resultatImage[1])) {
        _selectedImageUrls.remove(resultatImage[0]);
        imageIdsToDelete.remove(resultatImage[1]);
      } else {
        _selectedImageUrls.add(resultatImage[0]);
         imageIdsToDelete.add(resultatImage[1]);
      }
    });
    
  }
 void _removeSelectedPhotos() {
  setState(() {
    _photos.removeWhere((photo) => _selectedImageUrls.contains('${photo["image_data"]}'));
  });
}



  Future<void> deletePhoto() async {
    print("delete photo $_photos");
    
    try {
      await database.deleteMultipleImages(imageIdsToDelete);
       _removeSelectedPhotos(); 
       _selectedImageUrls.clear(); 
       ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Suppression terminée"),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.blue,
                  ),
                );
                return;
    } catch (e) {
       print("suppressing error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    final id = mainSession.userId;
    setState(() {
      _isLoading = false;
      _userId = id;
      _getData(_userId);
    });
  }

  void _sendSelectedPhotos() {
    if (_selectedImageUrls.isNotEmpty) {
      Navigator.pop(context, _selectedImageUrls);
    } else {
      print("Please select a new image");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
  title: Text(
    'Galerie',
    style: TextStyle(
      color: Colors.white,
      fontSize: 24, // Taille du texte
      fontWeight: FontWeight.bold, // Gras
    ),
  ),
  backgroundColor: Colors.transparent,
  elevation: 0,
  actions: [
    IconButton(
      onPressed: () {
        if (_photos.isNotEmpty){
       _showDeleteConfirmationDialog();
      }else{
        
          ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Aucune photo n'a été choisie!"),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.blue,
        ),
      );
      return;
      }
       
      },
      icon: Icon(
        Icons.delete_sharp,
        color: Colors.white,
        size: 28,
      ),
      splashRadius: 24,
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4,
      ),
    ),
    IconButton(
  onPressed: () {
     if (_selectedImageUrls.isNotEmpty){
       _sendSelectedPhotos();
      }else{
          ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Aucune photo n'a été choisie!"),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.blue,
        ),
      );
      return;
      }
  },
  icon: ClipRRect(
    borderRadius: BorderRadius.circular(12), 
    child: Container(
      color: Colors.transparent, 
      child: Icon(
        Icons.send,
        color: Colors.blue,
        size: 28,
      ),
    ),
  ),
  splashRadius: 24,
),

   
  ],
)
,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GridView.builder(
                        itemCount: _photos.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 3,
                        ),
                        itemBuilder: (context, index) {
                          final imageUrl = '${_photos[index]["image_data"]}';
                          final isSelected = _selectedImageUrls.contains(imageUrl);
                          final imageIndex=_photos[index]["id_image"];
                          List<dynamic> resultatImage = [imageUrl,imageIndex];
                          return GestureDetector(
                            onTap: () {
                              _onPhotoClicked(resultatImage);
                            },
                            child: Stack(
                              children: [
                                AnimatedOpacity(
                                  opacity: isSelected ? 0.5 : 1.0,
                                  duration: const Duration(milliseconds: 300),
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      image: DecorationImage(
                                        image: FileImage(File(imageUrl)),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  const Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Icon(Icons.check_circle, color: Colors.green, size: 30),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
  void _showDeleteConfirmationDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Confirmation de suppression"),
        content: Text("Êtes-vous sûr de vouloir supprimer ces photos ?"),
        actionsPadding: EdgeInsets.symmetric(horizontal: 20), 
        actions: [
          TextButton(
            child: const Text(
              "Annuler ",
              style: TextStyle(color: Colors.blue), 
            ),
            onPressed: () {
              Navigator.of(context).pop(); 
            },
          ),
          const SizedBox(width: 10), 
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red, 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), 
              ),
            ),
            child: const Text(
              "Supprimer",
              style: TextStyle(color: Colors.white, fontSize: 16), // Couleur et taille du texte
            ),
            onPressed: () {
              deletePhoto();
              Navigator.of(context).pop(); 
            },
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), 
        ),
      );
    },
  );
}

}
