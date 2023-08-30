import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'galerie_photo.dart';

class MyCamera extends StatefulWidget {
  const MyCamera({Key? key}) : super(key: key);

  @override
  _MyCameraState createState() => _MyCameraState();
}

class _MyCameraState extends State<MyCamera> {
  late CameraController _controller;
  String? _capturedImagePath;
  late Future<void> _initializeControllerFuture;
  bool _isCameraInitialized = false; 


  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    // _initializeControllerFuture = _controller.initialize();
     _initializeControllerFuture = _controller.initialize().then((_) {
      setState(() {
        _isCameraInitialized = true;
      });
    });
  }

  Future<void> _takePicture() async {
    if (!_isCameraInitialized) return; 
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();

      final appDir = await getApplicationDocumentsDirectory();
      final imageName = DateTime.now().toString() + '.png';
      final imagePath = appDir.path + '/' + imageName;

      setState(() {
        _capturedImagePath = imagePath; 
      });

      // Enregistrez l'image ici avec les données associées

      print('Image saved at: $imagePath');
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panorama Camera App'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.only(left: 30.0),
          child: Row(
            children: [
              FloatingActionButton(
                onPressed: () {
                  if (_capturedImagePath != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            GalleryPage(capturedImagePath: _capturedImagePath!),
                      ),
                    );
                  }
                },
                child: Icon(Icons.photo_library),
                backgroundColor: Colors.black12,
              ),
              FloatingActionButton(
                onPressed: _takePicture,
                child: Icon(Icons.camera),
                backgroundColor: Colors.black12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
