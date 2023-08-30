// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart'; // Pour la caméra
// import 'package:path_provider/path_provider.dart'; // Pour le stockage local

// class PhotoView extends StatefulWidget {
//   const PhotoView({Key? key}) : super(key: key);
//   @override
//   _PhotoViewState createState() => _PhotoViewState();
// }

// class _PhotoViewState extends State<PhotoView> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     final cameras = await availableCameras();
//     final firstCamera = cameras.first;

//     _controller = CameraController(
//       firstCamera,
//       ResolutionPreset.medium,
//     );

//     _initializeControllerFuture = _controller.initialize();
//   }

//   Future<void> _takePicture() async {
//     try {
//       await _initializeControllerFuture;
//       final image = await _controller.takePicture();

//       final appDir = await getApplicationDocumentsDirectory();
//       final imageName = DateTime.now().toString() + '.png';
//       final imagePath = appDir.path + '/' + imageName;

//       // Enregistrez l'image ici avec les données associées

//       print('Image saved at: $imagePath');
//     } catch (e) {
//       print('Error taking picture: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Panorama Camera App'),
//       ),
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return CameraPreview(_controller);
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _takePicture,
//         child: Icon(Icons.camera, color: Colors.red,),
//       ),
//     );
//   }
// }

// class PhotoViewWithHeroWithHero extends StatelessWidget {
//   const PhotoViewWithHeroWithHero({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(
//           MaterialPageRoute(builder: (_) => _DetailPhotoViewWithHero()),
//         );
//       },
//       child: Hero(
//         tag: 'photoHero', // Balise unique pour le widget Hero
//         child: Container(
//           color: Colors.blue,
//           child: Text('Cliquez pour voir la photo'),
//         ),
//       ),
//     );
//   }
// }

// class _DetailPhotoViewWithHero extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Hero(
//           tag: 'photoHero', // Utilisation de la même balise pour la transition
//           child: Container(
//             color: Colors.blue,
//             child: Text('Détail de la photo'),
//           ),
//         ),
//       ),
//     );
//   }
// }