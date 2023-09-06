import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_notabene/views/photos/print_camera.dart';

import '../../components/add_message_components.dart';

class ImagePreviewPage extends StatelessWidget {
  final String imagePath;

  const ImagePreviewPage({required this.imagePath});



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
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(imagePath)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                       Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Mydata(),
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
