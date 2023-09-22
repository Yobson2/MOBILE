import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_notabene/components/add_comm_sms.dart';
import 'package:flutter_notabene/views/photos/print_photo.dart';
import 'package:provider/provider.dart';
import '../../services/connectEtat.dart';
import 'package:http/http.dart' as http;

import '../idtest.dart';
import '../testMap.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  bool isLoading = true;
  List<dynamic> photos = []; 
   bool _isClicked = false;
   bool _isLoading = true;
   int? userId;

  List<String> selectedImageUrls = [];


  Future<void> getData(id) async {
    print("Loading $id");
    final result = await someAsyncMethod(id);
    print("object is loading $result");
    setState(() {
      photos = result; 
      print("object $photos");
       _isLoading = false; 
    });
  }

  Future<List<dynamic>> someAsyncMethod(id) async {
    final response = await http.get(Uri.parse('http://192.168.1.9:8082/apiNotabene/v1/getAllPhoto/$id'));
    final data = json.decode(response.body);
    return data;
  }

  //  void _onPhotoClicked( String imageUrl) {
  //   setState(() {
  //     _isClicked = true;
  //   });
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => CommentaireComponent( imageUrl: imageUrl),
  //     ),
  //   ).then((value) {
  //     setState(() {
  //       _isClicked = false;
  //     });
  //   });
  // }
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
    setState(() {
      isLoading = false;
    });
     _fetchAndDisplayUserId();
  }
  
  Future<void> _fetchAndDisplayUserId() async {
    final userData = UserData(); 
    final userId = await userData.getUserIdFromLocalStorage();
    if (userId != null) {
      setState(() {
        this.userId = userId;
        getData(userId);
      });
    }
     
  }
  void _sendSelectedPhotos() {
    if (selectedImageUrls.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectedPhotosPage(selectedImageUrls),
        ),
      );
      print("object: test $selectedImageUrls" );
    } else {
      
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Gallerie' ),
        actions: [
          ElevatedButton(
            onPressed: _sendSelectedPhotos,
            child: Text('Envoyer les photos sélectionnées'),
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
    final imageUrl = 'http://192.168.1.9:8082/images/${photos[index]["image"]}';
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
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          if (isSelected)
            Positioned(
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