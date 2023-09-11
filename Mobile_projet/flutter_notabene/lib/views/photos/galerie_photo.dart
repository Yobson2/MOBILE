import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../services/connectEtat.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  late Future<List<String>> futurePhotos;

 Future<List<String>> fetchServerPhotos(id) async {
  final response = await http.get(Uri.parse('http://192.168.1.8:8082/apiNotabene/v1/getAllPhoto'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    List<String> photoPaths = [];

    for (var item in data) {
      if (item is String) {
        photoPaths.add(item);
      }
    }

    return photoPaths.where((path) => path.contains('id_photos=$id')).toList();
  } else {
    throw Exception('Failed to load photos from server');
  }
}



  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.getUserIdFromStorage();
    futurePhotos = fetchServerPhotos(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      body: FutureBuilder<List<String>>(
        future: futurePhotos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<String> photoPaths = snapshot.data!;
            return ListView.builder(
              itemCount: photoPaths.length,
              itemBuilder: (context, index) {
                return Image.network(photoPaths[index]);
              },
            );
          }
        },
      ),
    );
  }
}
