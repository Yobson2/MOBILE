import 'package:flutter/material.dart';
import 'package:flutter_notabene/views/photos/camera_photo.dart';

class PrintCamera extends StatelessWidget {
  const PrintCamera({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Center(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            color: Colors.blue,
            height: 900,
            width: 500,
            child: Container(
              color: Colors.black12,
              child: const MyCamera()
              ),
            ),
          ),
        ),
      );
  }
}
