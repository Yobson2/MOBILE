import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



import 'ImagePreviewPage.dart';
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
  bool _isFrontCamera = false; 

  _MyCameraState() {
    _initializeControllerFuture = _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final camera = _isFrontCamera ? cameras.last : cameras.first; // Use the selected camera

    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
    );

    await _controller.initialize();

    setState(() {
      _isCameraInitialized = true;
    });
  }

  void _toggleCamera() {
    setState(() {
      _isFrontCamera = !_isFrontCamera;
      _isCameraInitialized = false;
    });
    // _controller.dispose();
    _initializeCamera();
  }

  void _navigateToImagePreview( imagePath) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ImagePreviewPage(imagePath: imagePath),
    ),
  );
}


  Future<void> _takePicture() async {
  if (!_isCameraInitialized) return;
  try {
    await _initializeControllerFuture;
    final image = await _controller.takePicture();
    setState(() {
      _capturedImagePath = image.path;
    });

    _navigateToImagePreview(_capturedImagePath);

    print('Image saved at: $_capturedImagePath');
    
    // Arrêtez le flux de l'image après avoir pris la photo
    // _controller.dispose();

  } on PlatformException catch (e) {
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
        title: const Text('Notabene Camera'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SizedBox(
              height: 800,
              child: CameraPreview(_controller),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin:const EdgeInsets.only(left: 30.0),
          child: Row(
            children: [
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GalleryPage(),
                    ),
                  );
                },
                child: Icon(Icons.photo_library),
                backgroundColor: Colors.black12,
              ),
              FloatingActionButton(
                onPressed: _takePicture,
                child: const Icon(Icons.camera),
                backgroundColor: Colors.black12,
              ),
              FloatingActionButton( 
                onPressed: _toggleCamera,
                child: Icon(_isFrontCamera ? Icons.camera_rear : Icons.camera_front),
                backgroundColor: Colors.black12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
