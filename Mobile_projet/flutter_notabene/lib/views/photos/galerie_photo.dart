import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class GalleryPage extends StatelessWidget {
   final String? capturedImagePath;
  const GalleryPage({super.key, this.capturedImagePath});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: FutureBuilder<List<String>>(
        future: _loadImagesAndVideos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading gallery'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No images or videos found.'));
          } else {
             final allImagePaths = snapshot.data!;
              if (capturedImagePath != null) {
                allImagePaths.add(capturedImagePath!);
              }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Image.file(File(snapshot.data![index]));
              },
            );
          }
        },
      ),
    );
  }

  Future<List<String>> _loadImagesAndVideos() async {
    final appDir = await getApplicationDocumentsDirectory();
    final files = appDir.listSync();
    final imageAndVideoPaths = files
        .where((file) =>
            file is File &&
            (file.path.endsWith('.png') || file.path.endsWith('.jpg') || file.path.endsWith('.mp4')))
        .map((file) => file.path)
        .toList();
    return imageAndVideoPaths;
  }
}
