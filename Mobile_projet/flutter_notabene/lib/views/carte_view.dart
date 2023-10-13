import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_notabene/screens/login_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../components/add_comm_sms.dart';
import '../main.dart';

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

  String? place1;
  static const apiKey = 'AIzaSyCRD-FSgdo6Tcpoj-RTuLQfmERxBagzm04';
  static const apiUrl='https://maps.googleapis.com/maps/api/place/textsearch/json?query';

  Marker _kUserMarker = const Marker(
    markerId: MarkerId("user_marker"),
    infoWindow: InfoWindow(title: "user_marker"),
    position: LatLng(5.3709971, -3.9164684),
  );

  List<String> suggestions = [];
  LatLng? selectedLocation;
  bool useManualCursor = true;
  bool testcard = false;
  bool isLoading = false;

  bool showCurrentUserLocation = true;
  bool isLoadingCarte=false;

  late double latitude2 ;
  late double longitude2;



  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(5.3709971, 0),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    latitude2 = 0.0; 
    longitude2 = 0.0; 
  }

 
//Afficher la position actuelle de l'utilisateur
  Future<void> _getUserLocation() async {
    setState(() {
    isLoading = true; 
  });
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
        infoWindow: const InfoWindow(title: "Votre position actuelle"),
        position: userLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
    });

    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newLatLng(userLocation));
    await getPlaceInfo(latitude, longitude);

  Timer(Duration(seconds: 1), () {
    setState(() {
      isLoading = false; // Cacher l'indicateur de chargement
      // isLoadingCarte=true;
    });
     latitude2 = latitude; 
    longitude2 = longitude; 
  });

 
  }


//Recuperer des infos sur la position actuelle de l'utilisateur
  Future<void> getPlaceInfo(double latitude, double longitude) async {
  final url = Uri.parse('$apiUrl=$latitude,$longitude&key=$apiKey');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> results = data['results'];

    if (results.isNotEmpty) {
      setState(() {
         if (showCurrentUserLocation) {
            placeAddress = results[0]['formatted_address'];
            placeName = results[0]['name'];
         }
      });
    }
  } else {
    throw Exception('Erreur lors de la recherche d\'endroits');
  }
}


  Future<void> searchPlaces(String query) async {
    
    final url = Uri.parse(
        '$apiUrl=$query&key=$apiKey');

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
        setState(() {
          
          latitude2=latitude ;
          longitude2=longitude;
        });
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
        // testcard =true;
          showCurrentUserLocation=false; 
      });
      


      searchPlaceInfo(tappedPoint.latitude, tappedPoint.longitude);
       setState(() {
          
          latitude2=tappedPoint.latitude ;
          longitude2=tappedPoint.longitude;
        });
    }
  }

  Future<void> searchPlaceInfo(double latitude, double longitude) async {
  
    
    final url = Uri.parse('$apiUrl=$latitude,$longitude&key=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      if (results.isNotEmpty) {
        setState(() {
          placeAddress= results[0]['formatted_address'];
          placeName = results[0]['name'];
        });
      }
    } else {
      throw Exception('Erreur lors de la recherche d\'endroits');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = mainSession.userId != 0;

    return Scaffold(
      
      appBar: AppBar(
          elevation: 0.0, 
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: 600,
          decoration: BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [ 
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
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
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              hintText: 'Recherche....',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            color: Colors.black,
            onPressed: showSelectedLocation,
            icon: Icon(Icons.gps_fixed),
          )
        ],
      ),

    
      body: Stack(
        children: [
          if (isLoading) 
          const Center(
            child: CircularProgressIndicator(), 
          ),
          GoogleMap(
            mapType: MapType.normal,
            markers: {
              if (showCurrentUserLocation) 
                    _kUserMarker,
              if (selectedLocation != null)
                Marker(
                  markerId: MarkerId("selected_location "),
                  position: selectedLocation!,
                  infoWindow: InfoWindow(title: "Endroit sélectionné"),
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
          if (suggestions.isNotEmpty)
            Positioned(
              left: 10.0,
              right: 10.0,
              top: 0.0,
              child: Container(
                 width: 200,
                  height: 400,
                decoration: BoxDecoration(
                  
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child:
                  ListView.builder(
                    itemCount: suggestions.length,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Container(
                          height: 40,
                          // color: Colors.amber,
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 2.0,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.place),
                              SizedBox(width: 10,),
                              Flexible( 
                                child: Text(
                                  suggestions[index],
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          onSuggestionSelected(suggestions[index]);
                        },
                      );
                    },
                  ),
              ),

              ),

            //  if (isLoadingCarte) 
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
                                  width: 200,
                                  height: 40,
                                   child: ElevatedButton(
                                     onPressed: () {
                                  if (isLoggedIn) {
                                    
                                     Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CommentaireComponent(
                                        placeName: placeName ?? "",
                                        placeAddress: placeAddress ?? "",
                                        latitude: latitude2,
                                        longitude: longitude2 ,
                                      ),
                                    ),);
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  }
                                },
                                      child: const Text('Terminé'),
                                    ),
                                 ),


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

}