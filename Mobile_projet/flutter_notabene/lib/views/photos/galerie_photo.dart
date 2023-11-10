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

  Future<void> _getData(id) async {
    final result = await _someAsyncMethod(id);
    setState(() {
      _photos = result;
      _isLoading = false;
    });
  }

  Future<List<dynamic>> _someAsyncMethod(id) async {
    final response = await database.getUserImages(id);
    return response;
  }

  void _onPhotoClicked(String imageUrl) {
    setState(() {
      if (_selectedImageUrls.contains(imageUrl)) {
        _selectedImageUrls.remove(imageUrl);
      } else {
        _selectedImageUrls.add(imageUrl);
      }
    });
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
        // Gérer l'action de suppression
        ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Aucune photo n'a été choisie!"),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.blue,
                  ),
                );
                return;
      },
      icon: Icon(
        Icons.delete_sharp,
        color: Colors.red,
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
    // _sendSelectedPhotos,
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Aucune photo n'a été choisie!"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.blue,
      ),
    );
    return;
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

                          return GestureDetector(
                            onTap: () {
                              _onPhotoClicked(imageUrl);
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
}
