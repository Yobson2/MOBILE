import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarteView extends StatelessWidget {
   CarteView({Key? key}) : super(key: key);

  final LatLng currentLocation = LatLng(25.1193, 53.3773);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carte'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: currentLocation,
          zoom: 15,
        ),
      ),
    );
  }
}
