import 'package:flutter/material.dart';
import 'package:flutter_notabene/views/photos/camera_photo.dart';

class PhotoViewWithHero extends StatelessWidget {
  const PhotoViewWithHero({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
        body: Container(
          color: Colors.blue,
          height: 900,
          child:Container(
            color: Colors.black12,
            child: const MyCamera(),
          )
        ),
        
      );
  }
}
