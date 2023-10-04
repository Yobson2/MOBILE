import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_notabene/views/photos/print_camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;


import '../../components/add_comm_sms.dart';
import '../../main.dart';


class ImagePreviewPage extends StatefulWidget {
  final String imagePath;

  const ImagePreviewPage({required this.imagePath});

  @override
  _ImagePreviewPageState createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  bool _isLoading = false;
   final id= mainSession.userId;
  

  Future<void> savePhoto(int userId) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await database.insertData(userId, widget.imagePath);
      Navigator.pop(context);
     print("Success image loaded in database sqlite");
    } catch (e) {
      print('Erreur lors de l\'envoi de l\'image: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon image '),
        backgroundColor: Colors.black,
        actions: [
        IconButton(
          icon: Icon(Icons.edit), 
          onPressed: () {
            
          },
        ),
        IconButton(
          icon: Icon(Icons.share), 
          onPressed: () {
            //  Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => CommentaireComponent(imageUrl: widget.imagePath),
            //             ),
            //           );
          },
        ),
      ],
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
                  ElevatedButton.icon(
                    onPressed: () {
                      savePhoto(id);
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('Enregistrer'),
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrintCamera(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.delete_forever),
                    label: const Text('Supprimer'),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
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
