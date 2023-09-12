import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_notabene/views/photos/galerie_photo.dart';
import 'package:flutter_notabene/views/photos/print_camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../services/connectEtat.dart';
import '../photo_view.dart';


class ImagePreviewPage extends StatefulWidget {
  final String imagePath;

  const ImagePreviewPage({required this.imagePath});

  @override
  _ImagePreviewPageState createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  bool _isLoading = false;
  

 Future<void> savePhoto(int userId) async {
  setState(() {
    _isLoading = true;
  });
      await Geolocator.checkPermission();
      await Geolocator.requestPermission();

      

  final url = Uri.parse("http://192.168.1.10:8082/apiNotabene/v1/sendPhotoLocalisation/$userId");

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
      print('Image envoyée avec succès');

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
    final userProvider = Provider.of<UserProvider>(context);
    userProvider.getUserIdFromStorage();

    // Maintenant vous pouvez accéder à l'ID
    final userId = userProvider.userId;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon image '),
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
                      savePhoto(userId!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const  PhotoViewWithHero(),
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
