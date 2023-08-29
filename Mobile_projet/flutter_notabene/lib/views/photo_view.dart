import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class PhotoView extends StatefulWidget {
  const PhotoView({Key? key}) : super(key: key);

  @override
  _PhotoViewState createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    _controller=CameraController(
      const CameraDescription(
        name: '0', 
        lensDirection: CameraLensDirection.back, 
        sensorOrientation: 1),
        ResolutionPreset.medium
      
      );
       _initializeControllerFuture = _controller.initialize();
      super.initState();
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

//=======USER INTERFACE=======//  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
     floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.white,
      child: Icon(Icons.camera, ),
      onPressed: (){
        try {
          
        } catch (error) {
           print("Error:  $error"); 
        }
      }),
    );
  }
}
