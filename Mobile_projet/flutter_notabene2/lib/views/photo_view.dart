import 'package:flutter/material.dart';
import 'package:flutter_notabene2/views/photos/galerie_photo.dart';

class PhotoViewWithHero extends StatelessWidget {
  const PhotoViewWithHero({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => DetailPhotoView()),
        );
      },
      child: Scaffold( 
        body: Container(
          color: Colors.blue,
          child:Container(
            color: Colors.black12,
          )
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.only(left: 30.0),
            child: Row(
              children: [
                  FloatingActionButton( 
                  onPressed: () {
                    print("This is my galery");
                  },
                  child: Icon(Icons.photo_library),
                  backgroundColor: Colors.black12,
                ),
                FloatingActionButton( 
                  onPressed: () {
                    print("This is my camera...");
                  },
                  child: Icon(Icons.camera),
                  backgroundColor: Colors.black12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
