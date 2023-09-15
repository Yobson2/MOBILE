import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_notabene/components/add_comm_sms.dart';
import 'package:flutter_notabene/views/photos/print_photo.dart';
import 'package:provider/provider.dart';
import '../../services/connectEtat.dart';
import 'package:http/http.dart' as http;

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  bool isLoading = true;
  List<dynamic> photos = []; 
   bool _isClicked = false;
   bool _isLoading = true;

  Future<void> getData(id) async {
    setState(() {
    _isLoading = true;
  });
    final result = await someAsyncMethod(id);
    print("object is loading $result");
    setState(() {
      photos = result; 
      print("object $photos");
       _isLoading = false; 
    });
  }

  Future<List<dynamic>> someAsyncMethod(id) async {
    final response = await http.get(Uri.parse('http://192.168.25.202:8082/apiNotabene/v1/getAllPhoto/$id'));
    final data = json.decode(response.body);
    return data;
  }

   void _onPhotoClicked( String imageUrl) {
    setState(() {
      _isClicked = true;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentaireComponent( imageUrl: imageUrl),
      ),
    ).then((value) {
      setState(() {
        _isClicked = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.userId;
    getData(userId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userId = userProvider.userId;

    return Scaffold(
      appBar: AppBar(
        title: Text('Gallerie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: _isLoading
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GridView.builder(
                        itemCount: photos.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 3,
                        ),
                        itemBuilder: (context, index) {
                          final imageUrl = 'http://192.168.25.202:8082/images/${photos[index]["image"]}';
                          return GestureDetector(
                            onTap: () {
                              _onPhotoClicked(
                                // photos[index]["id_photos"].toString(),
                                imageUrl
                              );
                            },
                            child: AnimatedOpacity(
                              opacity: _isClicked ? 0.5 : 1.0,
                              duration: Duration(milliseconds: 300),
                              child: Container(
                                margin: EdgeInsets.only(top: 8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: NetworkImage(imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}