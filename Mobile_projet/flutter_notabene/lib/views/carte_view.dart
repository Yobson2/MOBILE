import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapSample extends StatefulWidget {
  const MapSample({Key? key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final TextEditingController _searchController = TextEditingController();
  String? placeName;
  String? placeAddress;

  Marker _kUserMarker = const Marker(
    markerId: MarkerId("user_marker"),
    infoWindow: InfoWindow(title: "user_marker"),
    position: LatLng(5.3709971, -3.9164684),
  );

  List<String> suggestions = [];
  LatLng? selectedLocation;
  bool useManualCursor = true;
  bool testcard = false;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(5.3709971, 0),
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
    LatLng userLocation = LatLng(latitude, longitude);

    setState(() {
      _kUserMarker = Marker(
        markerId: const MarkerId("position"),
        infoWindow: const InfoWindow(title: "position actuelle"),
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
      final List<dynamic> results = data['results'];

      suggestions = results.map((result) {
        return result['name'] +' '+ result['formatted_address'] as String;
      }).toList();

      if (suggestions.isNotEmpty) {
        final Map<String, dynamic> location =
            results[0]['geometry']['location'];

        double latitude = location['lat'];
        double longitude = location['lng'];
        placeName = results[0]['name'];
        placeAddress = results[0]['formatted_address'];
        LatLng userLocation = LatLng(latitude, longitude);

        final GoogleMapController controller = await _controller.future;
        await controller.animateCamera(CameraUpdate.newLatLng(userLocation));

        if (useManualCursor) {
          setState(() {
            selectedLocation = userLocation;
          });
        }
        setState(() {
          useManualCursor = true;
        });
      } else {
        // Aucun résultat trouvé
      }
    } else {
      throw Exception('Erreur lors de la recherche d\'endroits');
    }
  }

  void onSuggestionSelected(String suggestion) async {
    await searchPlaces(suggestion);

    setState(() {
      suggestions = [];
      useManualCursor = false;
      _searchController.text = suggestion;
      testcard = true; 
    });
  }

  void showSelectedLocation() async {
    if (selectedLocation != null) {
      final GoogleMapController controller = await _controller.future;
      await controller.animateCamera(CameraUpdate.newLatLng(selectedLocation!));
    }
  }

  void onMapTap(LatLng tappedPoint) {
    if (useManualCursor) {
      setState(() {
        selectedLocation = tappedPoint;
        testcard =true;
      });

      searchPlaceInfo(tappedPoint.latitude, tappedPoint.longitude);
    }
  }

  Future<void> searchPlaceInfo(double latitude, double longitude) async {
    final apiKey = 'AIzaSyCRD-FSgdo6Tcpoj-RTuLQfmERxBagzm04';
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      if (results.isNotEmpty) {
        setState(() {
          placeAddress= results[0]['formatted_address'];
          placeName = "test address";
        });
      }
    } else {
      throw Exception('Erreur lors de la recherche d\'endroits');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            markers: {
              _kUserMarker,
              if (selectedLocation != null)
                Marker(
                  markerId: MarkerId("selected_location"),
                  position: selectedLocation!,
                  infoWindow: InfoWindow(title: "Selected Location"),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                ),
            },
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onTap: onMapTap,
            zoomControlsEnabled: false,
          ),
          Positioned(
            left: 10.0,
            right: 10.0,
            top: 40.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: TextField(
                 controller: _searchController,
                onChanged: (query) {
                  if (query.isNotEmpty) {
                    searchPlaces(query);
                  } else {
                    setState(() {
                      suggestions = [];
                      testcard = false; 
                    });
                  }
                },
                style: TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  
                  prefix: Icon(
                    Icons.search_sharp, color: Colors.black
                  ),
                  hintText: 'Recherche de Lieu',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          if (suggestions.isNotEmpty)
            Positioned(
              left: 10.0,
              right: 10.0,
              top: 85.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: ListView.builder(
                  itemCount: suggestions.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(suggestions[index]),
                      onTap: () {
                        onSuggestionSelected(suggestions[index]);
                      },
                    );
                  },
                ),
              ),
            ),
              if (testcard )
             Positioned(
            left: 10.0,
            right: 10.0,
            bottom: 10.0, 
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 400,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Nom de l'endroit: $placeName",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        Text("Adresse: $placeAddress"),
                        const SizedBox(height: 10.0), 
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              
                              SizedBox(
                                  width: 310,
                                  height: 40,
                                   child: ElevatedButton(
                                      onPressed: _showModal,
                                      child: const Text('Terminé'),
                                    ),
                                 ),
                               IconButton(
                                color: Colors.blue,
                                onPressed: showSelectedLocation,
                                 icon: Icon(Icons.gps_fixed)
                                )  
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }


void _showModal() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Container(
          width: 350,
          height: 300,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.blue,
                size: 48.0,
              ),
              const SizedBox(height: 16.0),
              const Text(
                "Que voulez-vous faire  ?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
        
              const SizedBox(height: 20.0), 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   ElevatedButton.icon(
                onPressed: () {
                 
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.comment, size: 24),
                label: const Text('commenter '),
              ),
                  const SizedBox(width: 16.0),
                   ElevatedButton.icon(
                onPressed: () {
                 
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.explore, size: 24),
                label: const Text('Explorer'),
              ),
                  
                ],
              ),
              const SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); 
                },
                child: Text(
                  'Annuler',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}


}


