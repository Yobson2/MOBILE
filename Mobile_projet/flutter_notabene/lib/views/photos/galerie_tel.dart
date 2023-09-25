import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../services/connectEtat.dart';

class MyImagePicker extends StatefulWidget {
  @override
  _MyImagePickerState createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  final picker = ImagePicker();
  XFile? _imageFile;

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = pickedFile;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    // userProvider.getUserIdFromStorage();

    // Maintenant vous pouvez accéder à l'ID
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_imageFile != null)
              Image.file(
                File(_imageFile!.path),
                width: 800,
                height: 450,
              )
            else
              Text('Aucune image sélectionnée'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                     onPressed: _pickImageFromGallery,
                    icon: const Icon(
                      Icons.check_box_outline_blank_sharp,
                      color: Colors.blue,
                      size: 32.0,
                    ),
                  ),
                IconButton(
                    onPressed: () {
                      print("object bjfb");
                    },
                    icon: const Icon(
                      Icons.check,
                      color: Colors.blue,
                      size: 32.0,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
