// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;

// class MapSample extends StatefulWidget {
//   const MapSample({super.key});

//   @override
//   State<MapSample> createState() => MapSampleState();
// }

// class MapSampleState extends State<MapSample> {
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();
//   final TextEditingController _searchController = TextEditingController();
//   LatLng kUserLocation = LatLng(0, 0);

//   Marker _kUserMarker = const Marker(
//     markerId: MarkerId("user_marker"),
//     infoWindow: InfoWindow(title: "user_marker"),
//     position: LatLng(0, 0),
//   );

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(0, 0),
//     zoom: 14.4746,
//   );

//   @override
//   void initState() {
//     super.initState();
//     _getUserLocation();
//   }

//   Future<void> _getUserLocation() async {
//     await Geolocator.checkPermission();
//     await Geolocator.requestPermission();

//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );

//     double latitude = position.latitude;
//     double longitude = position.longitude;

//     LatLng userLocation = LatLng(latitude, longitude);

//     setState(() {
//       _kUserMarker = Marker(
//         markerId: const MarkerId("position"),
//         infoWindow: const InfoWindow(title: "position"),
//         position: userLocation,
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//       );
//     });

//     final GoogleMapController controller = await _controller.future;
//     await controller.animateCamera(CameraUpdate.newLatLng(userLocation));
//   }
// Future<void> searchPlaces(String query) async {
//   final apiKey = 'AIzaSyCRD-FSgdo6Tcpoj-RTuLQfmERxBagzm04';
//   final url = Uri.parse(
//       'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&key=$apiKey');

//   final response = await http.get(url);

//   if (response.statusCode == 200) {
//     final Map<String, dynamic> data = json.decode(response.body);
//     final Map<String, dynamic> location = data['results'][0]['geometry']['location'];
//     double latitude = location['lat'];
//     double longitude = location['lng'];

//     LatLng userLocation = LatLng(latitude, longitude);

//     setState(() {
//       _kUserMarker = Marker(
//         markerId: const MarkerId("position"),
//         infoWindow: const InfoWindow(title: "position"),
//         position: userLocation,
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//       );
//     });

//     final GoogleMapController controller = await _controller.future;
//     await controller.animateCamera(CameraUpdate.newLatLng(userLocation));
//   } else {
//     throw Exception('Erreur lors de la recherche d\'endroits');
//   }
// }

//   void _search() {
//     final query = _searchController.text;
//     searchPlaces(query);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TextField(
//           controller: _searchController,
//           decoration: InputDecoration(
//             hintText: 'Search...',
//             border: InputBorder.none,
//             suffixIcon: IconButton(
//               icon: Icon(Icons.search),
//               onPressed: _search,
//             ),
//           ),
//         ),
//       ),
//       body: GoogleMap(
//         mapType: MapType.normal,
//         markers: {
//           _kUserMarker,
//         },
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//     );
//   }
// }
