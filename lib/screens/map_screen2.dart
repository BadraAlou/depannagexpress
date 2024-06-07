import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen2 extends StatefulWidget {
  const MapScreen2({super.key});

  @override
  State<MapScreen2> createState() => _MapScreen2State();
}

class _MapScreen2State extends State<MapScreen2> {
  GoogleMapController? mapController;
  //Location location = Location(); // Create a Location instance
  Set<Marker> markers = {};
  //Position garagePosition = LatLng(12.6200175, -8.0035281);

  late Position _currentPosition;
  String _currentAddress = '';

  List<Polyline> polyLine = [];

  // void _addPolyline() {
  //   polyLine.add(Polyline(
  //     polylineId: PolylineId("route1"),
  //     color: Colors.blue,
  //     patterns: [
  //       PatternItem.dash(20.0),
  //       PatternItem.gap(10)
  //     ],
  //     width: 3,
  //     points: [
  //       LatLng(12.6200175, -8.0035281),
  //       LatLng(_currentPosition.latitude, _currentPosition.longitude),
  //     ],
  //   ));
  // }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      markers.add(Marker(
        markerId: MarkerId('marker1'),
        //position: LatLng(12.6027806, -7.9936909), // Daoudabougou
        position: LatLng(12.6200175, -8.0035281), // BAdalagougou garage
        infoWindow: InfoWindow(title: 'Garage'),

      ));

      // markers.add(Marker(
      //   markerId: MarkerId('marker2'),
      //   position: LatLng(12.5884952, -8.0634796), // Sebenicoro
      //   infoWindow: InfoWindow(title: 'Oui Sebenicoro'),
      // ));

    });
    //locatePosition();
    _getCurrentLocation();
    //_addPolyline();
  }

  Future<void> _getUserLocation() async {
    // final userLocation = await location.getLocation();
    // setState(() {
    //   markers.add(Marker(
    //     markerId: MarkerId('userLocation'),
    //     position: LatLng(userLocation.latitude!, userLocation.longitude!),
    //     infoWindow: InfoWindow(title: 'Your Location'),
    //   ));
    // });
  }

  void locatePosition() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    //currentPosition = position;
    print('*** Yo position : $position');
    LatLng latLatPosition = LatLng(position.latitude, position.longitude);
    setState(() {
      markers.add(Marker(
        markerId: MarkerId('userLocation'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: InfoWindow(title: 'Your Location'),
      ));
    });
    // CameraPosition cameraPosition = new CameraPosition(target: latLatPosition, zoom: 14);
    // newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    //
    // String address = await AssistantMethods.searchCoordinateAddress(position, context);
    // print("This is your address :: " + address);
    //
    // initGeoFireLister();
  }


  _getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    print('*/*/ yo la valeur de persmission: $permission');

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print('*** Yo current position: $position');
    setState(() {
      _currentPosition = position;
      markers.add(Marker(
        markerId: MarkerId('userLocation'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: InfoWindow(title: 'Votre Position'),
      ));
    });
    _getAddressFromLatLng();
  }

  _getAddressFromLatLng() async {
    try {

      List<Placemark> placemarks = await placemarkFromCoordinates(_currentPosition.latitude, _currentPosition.longitude);
      //List<Placemark> placemarks = await placemarkFromCoordinates(12.6027806, -7.9936909);

      Placemark place = placemarks[0];
      print('*** Yo la place : $place');

      setState(() {
        // _currentAddress =
        // "${place.name}, ${place.thoroughfare}, ${place.subThoroughfare}, "
        //     "${place.locality}, ${place.administrativeArea} ${place.postalCode}, ${place.country}";
        _currentAddress = "${place.subLocality}, ${place.locality}";

        print('Yo adresse courant : $_currentAddress');
      });
    } catch (e) {
      print(e);
    }
  }

  Set<Polyline> polylines = {
    Polyline(
      polylineId: PolylineId('route1'),
      points: [
        LatLng(12.6200175, -8.0035281),
        //LatLng(_currentPosition.latitude, _currentPosition.longitude),
        LatLng(12.6027806, -7.9936909),
      ],
      color: Colors.blue,
      width: 4,
    ),
  };

  Set<Polygon> polygons = {
    Polygon(
      polygonId: PolygonId('area1'),
      points: [
        LatLng(12.6200175, -8.0035281),
        //LatLng(_currentPosition.latitude, _currentPosition.longitude),
        LatLng(12.6027806, -7.9936909),
      ],
      fillColor: Colors.green.withOpacity(0.3),
      strokeColor: Colors.green,
      strokeWidth: 2,
    ),
  };

  @override
  void initState() {
    //_getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Maps in Flutter')),
      body: Stack(
        children: [
          Positioned(
            top: 0, right: 0, left: 0, bottom: 100,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                //target: LatLng(37.7749, -122.4194), // San Francisco coordinates
                target: LatLng(12.6200175, -8.0035281), // Badalabougou Coordinates
                zoom: 12,
              ),
              markers: markers,
              myLocationButtonEnabled: true,
              //polylines: polyLine.toSet(),
              polylines:polylines,
              polygons: polygons,
            ),
          ),

          Positioned(
            bottom: 0, right: 0, left: 0,
              child: Card(
                child: Column(
                  children: [
                    Text('Adresse Courant: $_currentAddress'),
                    Text(_currentAddress),

                  ],
                ),
              )
          )
        ]

      ),
    );
  }
}
