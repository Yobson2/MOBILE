import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../components/add_comm_sms.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final TextEditingController _searchController = TextEditingController();
  LatLng kUserLocation = LatLng(5.3709971, -3.9164684);
  String? placeName;
  String? placeAddress;

  Marker _kUserMarker = const Marker(
    markerId: MarkerId("user_marker"),
    infoWindow: InfoWindow(title: "user_marker"),
    position: LatLng(5.3709971, -3.9164684),
  );

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(5.3709971, -3.9164684),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    double latitude = position.latitude;
    double longitude = position.longitude;
    // print(position.latitude);
    // print(position.longitude);
    LatLng userLocation = LatLng(latitude, longitude); //afficher la position actuelle ici

     

    setState(() {
      _kUserMarker = Marker(
        markerId: const MarkerId("position"),
        infoWindow: const InfoWindow(title: "position"),
        position: userLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
    });

    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newLatLng(userLocation));
  }
Future<void> searchPlaces(String query) async {
  final apiKey = 'AIzaSyCRD-FSgdo6Tcpoj-RTuLQfmERxBagzm04';
  final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&key=$apiKey');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final Map<String, dynamic> location = data['results'][0]['geometry']['location'];
    
    double latitude = location['lat'];
    double longitude = location['lng'];
    placeName = data['results'][0]['name'];
    placeAddress = data['results'][0]['formatted_address'];
    LatLng userLocation = LatLng(latitude, longitude);
    

    setState(() {
      _kUserMarker = Marker(
        markerId: const MarkerId("position"),
        infoWindow: const InfoWindow(title: "position"),
        position: userLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      );
    });

    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newLatLng(userLocation));
    
  } else {
    throw Exception('Erreur lors de la recherche d\'endroits');
  }
}

 Future<void> _search() async {
  final query = _searchController.text.trim(); // Utilisez trim() pour supprimer les espaces vides
  if (query.isEmpty) {
    // Si le champ de recherche est vide, réinitialiser les coordonnées
    setState(() {
      _kUserMarker = Marker(
        markerId: const MarkerId("position"),
        infoWindow: const InfoWindow(title: "position"),
        position: LatLng(5.3709971, -3.9164684), 
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
      placeName = null; 
      placeAddress = null; 
    });

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(LatLng(5.3709971, -3.9164684))); 
  } else {
    searchPlaces(query);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 63, 57, 57), 
      elevation: 0, 
      // automaticallyImplyLeading: false,
      title: TextField(
        controller: _searchController,
        style: const TextStyle(color: Colors.black), 
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: const TextStyle(color: Colors.grey), 
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: _search,
          ),
        ),
      ),
    ),
          body: Column(
            children: [
              Expanded(
                child: GoogleMap(
              mapType: MapType.normal,
              markers: {
                    _kUserMarker,
              },
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
              },
            ),),
            if (placeName != null && placeAddress != null)
           Card(
          elevation: 8, // Ajoute une ombre à la carte
          margin: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lieu trouvé :',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Icon(Icons.place),
                    Text('$placeName'),
                  ],
                ),
                Row(
                  children: [
                   const Icon(Icons.location_on),
                    Text('$placeAddress'),
                  ],
                ),
                const SizedBox(height: 16), 
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                        
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommentaireComponent(infos:placeName),
                          ));
                            },
                        child: Text('Commenter'),
                      ),
                    
                    const SizedBox(height: 16), 
                    ElevatedButton(
                        onPressed: () {
                         
                        },
                        child: Text('Explorer'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        )

            ],
          ),
    );
  }
}
