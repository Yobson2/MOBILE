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

  bool isLoading = true;
  List<dynamic> photos = []; 
   bool _isLoading = true;
   int? userId;

  List<String> selectedImageUrls = [];


  Future<void> getData(id) async {
   
    final result = await someAsyncMethod(id);
    setState(() {
      photos = result;
       _isLoading = false; 
    });
    
  }

  Future<List<dynamic>> someAsyncMethod(id) async {
    final response = await database.getUserImages(id);
    return response;
  }

  
  void _onPhotoClicked(String imageUrl) {
  setState(() {
    if (selectedImageUrls.contains(imageUrl)) {
      selectedImageUrls.remove(imageUrl);
    } else {
      selectedImageUrls.add(imageUrl);
    }
  });
}


  @override
  void initState() {
    super.initState();
     final id = mainSession.userId;
    setState(() {
      isLoading = false;
       this.userId = id;
        getData(userId);
    });
  }
  
  void _sendSelectedPhotos() {
    if (selectedImageUrls.isNotEmpty) {
      // selectedImageUrl_=selectedImageUrls
      //  mainSession.selectedImageUrl_=selectedImageUrls;
        Navigator.pop(context,selectedImageUrls);
        //  Navigator.pop(context);
        // Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(builder: (context) => const CommentaireComponent()),
        //     );
    } else {
      print("Please select a new image");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallerie ' ),
        actions: [
          ElevatedButton(
            onPressed: _sendSelectedPhotos,
            child: const Text('Envoyer les photos sélectionnées'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: _isLoading
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GridView.builder(
  itemCount: photos.length,
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    crossAxisSpacing: 20,
    mainAxisSpacing: 3,

  ),
  itemBuilder: (context, index) {
    final imageUrl = '${photos[index]["image_data"]}';
    
    final isSelected = selectedImageUrls.contains(imageUrl);

    return GestureDetector(
      onTap: () {
        _onPhotoClicked(imageUrl);
      },
      child: Stack(
        children: [
          AnimatedOpacity(
            opacity: isSelected ? 0.5 : 1.0,
            duration: Duration(milliseconds: 300),
            child: Container(
              margin: EdgeInsets.only(top: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
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
)

                    ),
                  ],
                ),
        ),
      ),
    );
  }
}