// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
//
// class MapScreen3 extends StatefulWidget {
//   const MapScreen3({super.key});
//
//   @override
//   State<MapScreen3> createState() => _MapScreen3State();
// }
//
// class _MapScreen3State extends State<MapScreen3> {
//   // Define the specific point (latitude and longitude)
//   LatLng specificPoint = const LatLng(37.4220, 122.0841);
//
//   Position currentLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
//   LatLng userLocation = LatLng(currentLocation.latitude, currentLocation.longitude);
//
//   // Create a list of polylines
//   List<Polyline> polylines = [
//     Polyline(
//       polylineId: const PolylineId('user_to_point'),
//       points: [userLocation, specificPoint],
//       color: Colors.blue,
//       width: 5,
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Yo Map'),),
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(target: userLocation, zoom: 15),
//         polylines: polylines,
//         myLocationEnabled: true,
//       ),
//     );
//   }
// }
