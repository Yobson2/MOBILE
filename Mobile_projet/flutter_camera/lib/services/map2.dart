import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ma Carte'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194), // Coordonnées initiales
          zoom: 12.0, // Niveau de zoom initial
        ),
      ),
    );
  }
}
