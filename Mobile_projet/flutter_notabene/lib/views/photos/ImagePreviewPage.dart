import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_notabene/views/photos/galerie_photo.dart';
import 'package:flutter_notabene/views/photos/print_camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;


class ImagePreviewPage extends StatefulWidget {
  final String imagePath;

  const ImagePreviewPage({required this.imagePath});

  @override
  _ImagePreviewPageState createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  bool _isLoading = false;
  // Future<void> _retrieveLocation() async {
  //     await Geolocator.checkPermission();
  //     await Geolocator.requestPermission();

  //     try {
  //       Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high,
  //       );

  //       double latitude = position.latitude;
  //       double longitude = position.longitude;

  //       print('Latitude: $latitude, Longitude: $longitude');
  //     } catch (e) {
  //       print('Erreur lors de la récupération de la position: $e');
  //     }
    
  // }


  

 Future<void> savePhoto() async {
  setState(() {
    _isLoading = true;
  });
  //  await _retrieveLocation(); 
      await Geolocator.checkPermission();
      await Geolocator.requestPermission();

      

  final url = Uri.parse("http://192.168.1.5:8082/apiNotabene/v1/sendPhotoLocalisation");

  var request = http.MultipartRequest('POST', url);

  Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        double latitude = position.latitude;
        double longitude = position.longitude;

  request.fields['latitude'] = latitude.toString();
  request.fields['longitude'] = longitude.toString();
  var image = await http.MultipartFile.fromPath("image", widget.imagePath);
  request.files.add(image);

  try {
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Latitude: $latitude, Longitude: $longitude');
      print('Image envoyée avec succès');
      // Arrêter le loader et rediriger vers une nouvelle page
      setState(() {
        _isLoading = false;
      });
      redirectToNewPage();
    } else {
      print('Erreur lors de l\'envoi de l\'image: ${response.statusCode}');
    }
  } catch (e) {
    print('Erreur lors de l\'envoi de l\'image: $e');
    setState(() {
      _isLoading = false;
    });
  }
}


  void redirectToNewPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PrintCamera(), 
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon image'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(File(widget.imagePath)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  _isLoading
                      ? CircularProgressIndicator()
                      : SizedBox(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      savePhoto();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GalleryPage(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.check,
                      color: Colors.blue,
                      size: 32.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrintCamera(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                      size: 32.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
