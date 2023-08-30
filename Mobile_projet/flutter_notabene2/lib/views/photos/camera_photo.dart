import 'dart:io';

import 'package:flutter/material.dart';

class DisplayPhotoScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPhotoScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Photo')),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}
