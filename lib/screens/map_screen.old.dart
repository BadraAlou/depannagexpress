import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:depannagexpress/controllers/map_controller.dart';
import 'package:depannagexpress/screens/search_screen.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:depannagexpress/widgets/Divider.dart';
import 'package:depannagexpress/widgets/progressDialog.dart';
import 'package:depannagexpress/assistants/assistantMethods.dart';
import 'package:depannagexpress/assistants/geoFireAssistant.dart';
import 'package:depannagexpress/data_handler/appData.dart';
import 'package:depannagexpress/models/directionDetails.dart';

import 'package:depannagexpress/config_maps.dart';
import 'package:depannagexpress/main.dart';
// import 'package:new_version/new_version.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'aboutScreen.dart';

class MainMapScreen extends StatefulWidget {
  static const String idScreen = "mainScreen";

  @override
  _MainMapScreenState createState() => _MainMapScreenState();
}



class _MainMapScreenState extends State<MainMapScreen> with TickerProviderStateMixin {

  // Users currentUser = Users();

  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  DirectionDetails tripDirectionDetails = DirectionDetails();

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  late Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  double rideDetailsContainerHeight = 0;
  double requestRideContainerHeight = 0;
  double searchContainerHeight = 300.0;

  bool drawerOpen = true;
  bool nearbyAvailableDriverKeysloaded = false;






  @override
  void initState() {

    getCurrentUserInfo();
    locatePosition();
    // getNewVersion();
    super.initState();

    AssistantMethods.getCurrentOnLineUserInfo();
  }

  void saveRideRequest() {
    // rideRequestRef = FirebaseDatabase.instance.reference().child("Ride Requests");
    //
    // var pickUp = Provider.of<AppData>(context, listen: false).pickUpLocation;
    // var dropOff = Provider.of<AppData>(context, listen: false).dropOffLocation;
    //
    // Map pickUpLocnMap = {
    //   "latitude": pickUp.latitude.toString(),
    //   "longitude": pickUp.longitude.toString(),
    // };
    //
    // Map dropOffLocnMap = {
    //   "latitude": dropOff.latitude.toString(),
    //   "longitude": dropOff.longitude.toString(),
    // };
    //
    // Map rideInfoMap = {
    //   "driver_id": "encours",
    //   "payment_method": "cash",
    //   "pickup": pickUpLocnMap,
    //   "dropoff": dropOffLocnMap,
    //   "created_at": DateTime.now().toString(),
    //   // "rider_name": userCurrentInfo.name,
    //   // "rider_phone": userCurrentInfo.phone,
    //   "rider_name": MyApp.globalCurrentUser.name,
    //   "rider_phone": MyApp.globalCurrentUser.phone,
    //   "pickup_adresse": pickUp.placeName,
    //   "dropoff_adresse": dropOff.placeName,
    // };
    //
    // if(MyApp.globalCurrentUser.name != "" && MyApp.globalCurrentUser.phone != "") {
    //   rideRequestRef.push().set(rideInfoMap);
    // } else {
    //   print("****** Impossible de faire la commande");
    //   print("***> Veillez vous deconnectez et vous reconnectez svp");
    //   displayToastMessage("Impossible de faire la commande. Veillez vous deconnectez et vous reconnectez svp", context);
    // }

  }

  void cancelRideRequest() {
    //rideRequestRef.remove();
  }

  void displayRequestRideContainer() {
    setState(() {
      requestRideContainerHeight = 250.0;
      rideDetailsContainerHeight = 0;
      bottomPaddingOfMap = 230.0;
      drawerOpen = true;
    });

    saveRideRequest();
  }

  resetApp() {
    setState(() {
      drawerOpen = true;
      searchContainerHeight = 300.0;
      rideDetailsContainerHeight = 0;
      requestRideContainerHeight = 0;
      bottomPaddingOfMap = 230.0;

      polylineSet.clear();
      markersSet.clear();
      circlesSet.clear();
      pLineCoordinates.clear();

    });

    locatePosition();
  }

  void displayRideDetailsContainer() async {
    await getPlaceDirection();

    setState(() {
      searchContainerHeight = 0;
      rideDetailsContainerHeight = 240.0;
      bottomPaddingOfMap = 230.0;

      drawerOpen = false;
    });
  }


  void locatePosition() async {
    // LocationPermission permission;
    // permission = await Geolocator.requestPermission();
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could show a dialog with
        // some explanation and a button to try again opening settings for this app
        return;
      }
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = new CameraPosition(target: latLatPosition, zoom: 14);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address = await AssistantMethods.searchCoordinateAddress(position, context);
    print("This is your address :: " + address);

    initGeoFireLister();
  }

  static final CameraPosition garagePlace = CameraPosition(
    target: LatLng(12.6200175, -8.0035281),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {



    createIconMarker();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Accueil"),
      ),
      // drawer: Container(
      //   color: Colors.white,
      //   width: 255.0,
      //   child: Drawer(
      //     child: ListView(
      //       children: [
      //         // Drawer Header
      //         Container(
      //           height: 165.0,
      //           child: DrawerHeader(
      //             decoration: BoxDecoration(color: Colors.orange),
      //             child: Row(
      //               children: [
      //                 Image.asset("images/user_icon.png", height: 65.0, width: 65.0,),
      //                 SizedBox(width: 16.0,),
      //                 Column(
      //                   children: [
      //                     SizedBox(height: 30,),
      //                     Text("NOM", style: TextStyle(fontSize: 16.0, fontFamily: "Brand-Regular"),),
      //                     SizedBox(height: 6.0,),
      //                     Text(MyApp.globalCurrentUser.name??"", style: TextStyle(fontSize: 12.0, fontFamily: "Brand-Regular"),),
      //                   ],
      //                 )
      //
      //               ],
      //             ),
      //           ),
      //         ),
      //
      //         DividerWidget(),
      //
      //         SizedBox(height: 12.0,),
      //
      //         // Drawer body controller
      //
      //         GestureDetector(
      //           onTap: () {
      //             Navigator.pushNamed(context, ProfileScreen.idScreen /*, (route) => false*/);
      //           },
      //           child: ListTile(
      //             leading: Icon(Icons.person),
      //             title: Text("Voir le profile", style: TextStyle(fontSize: 15.0),),
      //           ),
      //         ),
      //         GestureDetector(
      //           onTap: () {
      //             Navigator.pushNamed(context, InformationScreen.idScreen /*, (route) => false*/);
      //           },
      //           child: ListTile(
      //             leading: Icon(Icons.info),
      //             title: Text("Informations", style: TextStyle(fontSize: 15.0),),
      //           ),
      //         ),
      //         GestureDetector(
      //           onTap: () {
      //             Navigator.pushNamed(context, AboutScreen.idScreen /*, (route) => false*/);
      //           },
      //           child: ListTile(
      //             leading: Icon(Icons.info),
      //             title: Text("A propos", style: TextStyle(fontSize: 15.0),),
      //           ),
      //         ),
      //
      //
      //         GestureDetector(
      //           onTap: () {
      //             FirebaseAuth.instance.signOut();
      //             logoutUser();
      //             Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
      //           },
      //           child: ListTile(
      //             leading: Icon(Icons.logout),
      //             title: Text("Se déconnecter", style: TextStyle(fontSize: 15.0),),
      //           ),
      //         ),
      //
      //
      //       ],
      //     ),
      //   ),
      // ),

      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: garagePlace,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            polylines: polylineSet,
            markers: markersSet,
            circles: circlesSet,

            onMapCreated: (GoogleMapController controller){
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              setState(() {
                bottomPaddingOfMap = 300.0;
              });

              // Géolocaliser ma position
              locatePosition();
            },
          ),

          // HamburgerButton for Drawer
          Positioned(
            top: 38.0,
            left: 22.0,
            child: GestureDetector(
              onTap: () {
                if(drawerOpen) {
                  //scaffoldKey.currentState.openDrawer();
                } else {
                  resetApp();
                }

              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 6.0,
                        spreadRadius: 0.5,
                        offset: Offset(
                          0.7,
                          0.7,
                        ),
                      ),

                    ]
                ),
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon((drawerOpen) ? Icons.menu : Icons.close, color: Colors.black,),
                    radius: 20.0
                ),
              ),
            ),
          ),

          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: AnimatedSize(
              //vsync: this,
              curve: Curves.bounceIn,
              duration: new Duration(milliseconds: 160),
              child: Container(
                height: searchContainerHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 16.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),
                      ),
                    ]
                ),

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 6.0,),
                      Text("Bonjour,", style: TextStyle(fontSize: 10.0),),
                      Text("Ou allez vous?", style: TextStyle(fontSize: 20.0, fontFamily: "Brand Bold"),),
                      SizedBox(height: 20.0),

                      GestureDetector(
                        onTap: () async {
                          var res = await Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                          if(res == "obtainDirection") {
                            //await getPlaceDirection();
                            displayRideDetailsContainer();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 6.0,
                                  spreadRadius: 0.5,
                                  offset: Offset(0.7, 0.7),
                                ),
                              ]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(Icons.search, color: Colors.blueAccent,),
                                SizedBox(width: 10.0,),
                                Text("Rechercher")
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 24.0),
                      Row(
                        children: [
                          Icon(Icons.home, color: Colors.grey,),
                          SizedBox(width: 12.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    Provider.of<AppData>(context).pickUpLocation != null
                                        ? Provider.of<AppData>(context).pickUpLocation!.placeName!
                                        : "Ajouter une addresse"
                                    //"Ajouter une addresse"
                                ),
                                SizedBox(height: 4.0),
                                Text("Votre position actuelle", style: TextStyle(color: Colors.black54, fontSize: 12.0),)
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10.0),

                      // DividerWidget(),
                      //
                      // SizedBox(height: 10.0),
                      // Row(
                      //   children: [
                      //     Icon(Icons.work, color: Colors.grey,),
                      //     SizedBox(width: 12.0),
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text("Add Work"),
                      //         SizedBox(height: 4.0),
                      //         Text("Your office address", style: TextStyle(color: Colors.black54, fontSize: 12.0),)
                      //       ],
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: AnimatedSize(
              //vsync: this,
              curve: Curves.bounceIn,
              duration: new Duration(milliseconds: 160),
              child: Container(
                height: rideDetailsContainerHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0),),
                    boxShadow: [BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                    ]
                ),

                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 17.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.tealAccent,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              //Image.asset("images/taxi.png", height: 70.0, width: 80.0,),
                              Image.asset("assets/depanneuse.jpg", height: 70.0, width: 80.0,),
                              SizedBox(width: 16.0,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Moto", style: TextStyle(fontSize: 18.0, fontFamily: "Brand-Bold",),
                                  ),
                                  Text(
                                    ((tripDirectionDetails != null) ? tripDirectionDetails.distanceText.toString() : '') , style: TextStyle(fontSize: 16.0, color: Colors.grey,),
                                  ),
                                ],
                              ),

                              Expanded(child: Container()),
                              // Display ride amount
                              // Text(
                              //   ((tripDirectionDetails != null) ? '\$${AssistantMethods.calculateFares(tripDirectionDetails)}' : ''), style: TextStyle(fontFamily: "Brand-Bold",),
                              // ),

                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20.0,),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.moneyCheckAlt, size: 18.0, color: Colors.black54,),
                            SizedBox(width: 16.0,),
                            Text("Cash"),
                            SizedBox(width: 6.0,),
                            Icon(Icons.keyboard_arrow_down, color: Colors.black54, size: 16.0,),

                          ],
                        ),
                      ),

                      SizedBox(height: 20.0,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton(
                          // RaisedButton(
                          onPressed: () {
                            displayRequestRideContainer();
                          },
                          // color: Theme.of(context).accentColor,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Commander", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),
                                Icon(FontAwesomeIcons.biking, color: Colors.white, size: 18.0,),
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

              ),
            ),
          ),

          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0),),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 0.5,
                      blurRadius: 16.0,
                      color: Colors.black54,
                      offset: Offset(0.7, 0.7),
                    )
                  ]
              ),
              height: requestRideContainerHeight,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    SizedBox(height: 12.0,),
                    SizedBox(
                      width: double.infinity,
                      child: ColorizeAnimatedTextKit(
                          onTap: () {
                            print("Tap Event");
                          },
                          text: [
                            "Commande en cours...",
                            "Patientez svp...",
                            "Recherche d'un conducteur...",
                          ],
                          textStyle: TextStyle(
                              fontSize: 35.0,
                              fontFamily: "Signatra"
                          ),
                          colors: [
                            Colors.green,
                            Colors.purple,
                            Colors.pink,
                            Colors.blue,
                            Colors.yellow,
                            Colors.red,
                          ],
                          textAlign: TextAlign.center,
                          //alignment: AlignmentDirectional.topStart // or Alignment.topLeft
                      ),
                    ),

                    SizedBox(height: 22.0,),

                    GestureDetector(
                      onTap: () {
                        cancelRideRequest();
                        resetApp();
                      },
                      child: Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(26.0),
                          border: Border.all(width: 2.0, color: Colors.green[300]!),
                        ),
                        child: Icon(Icons.close, size: 26,),
                      ),
                    ),

                    SizedBox(height: 10.0,),

                    Container(
                      width: double.infinity,
                      child: Text("Annuler la commande", textAlign: TextAlign.center, style: TextStyle(fontSize: 12.0),),
                    ),

                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );


  }

  Future<void> getPlaceDirection() async {
    MapController mapController = Get.put(MapController());
    var initialPos = Provider.of<AppData>(context, listen: false).pickUpLocation;
    var finalPos = Provider.of<AppData>(context, listen: false).dropOffLocation;

    var pickUpLatLng = LatLng(initialPos!.latitude!, initialPos.longitude!);
    var dropOffLatLng = LatLng(finalPos!.latitude!, finalPos.longitude!);

    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(message: "Traitement encours, Patientez S'il vous plait ...",)
    );

    var details = await AssistantMethods.obtainPlaceDirectionDetails(pickUpLatLng, dropOffLatLng);
    // print("**************** place direction details : ");
    // print(details);
    setState(() {
      tripDirectionDetails = details;
    });

    Navigator.pop(context);

    print("This is Encoded Points ::");
    print(details.encodedPoints);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodePolylinePointsResult = polylinePoints.decodePolyline(details.encodedPoints);

    pLineCoordinates.clear();

    if(decodePolylinePointsResult.isNotEmpty) {
      decodePolylinePointsResult.forEach((PointLatLng pointLatLng) {
        pLineCoordinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    polylineSet.clear();

    setState(() {
      Polyline polyline = Polyline(
        color: Colors.pink,
        polylineId: PolylineId("PolylineID"),
        jointType: JointType.round,
        points: pLineCoordinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );

      polylineSet.add(polyline);

    });

    LatLngBounds latLngBounds;
    if(pickUpLatLng.latitude > dropOffLatLng.latitude && pickUpLatLng.longitude > dropOffLatLng.longitude) {

      latLngBounds = LatLngBounds(southwest: dropOffLatLng, northeast: pickUpLatLng);

    } else if(pickUpLatLng.longitude > dropOffLatLng.longitude) {

      latLngBounds = LatLngBounds(southwest: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude), northeast: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude));

    } else if (pickUpLatLng.latitude > dropOffLatLng.latitude) {

      latLngBounds = LatLngBounds(southwest: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude), northeast: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude));

    } else {
      latLngBounds = LatLngBounds(southwest: pickUpLatLng, northeast: dropOffLatLng);
    }

    newGoogleMapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker pickUpLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      infoWindow: InfoWindow(title: initialPos.placeName, snippet: "Ma position"),
      position: pickUpLatLng,
      markerId: MarkerId("pickUpID"),
    );

    Marker dropOffLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(title: finalPos.placeName, snippet: "Ma destination"),
      position: dropOffLatLng,
      markerId: MarkerId("dropOffID"),
    );

    setState(() {
      markersSet.add(pickUpLocMarker);
      markersSet.add(dropOffLocMarker);
    });

    Circle pickUpLocCircle = Circle(
      fillColor: Colors.blue,
      center: pickUpLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.blueAccent,
      circleId: CircleId("pickUpID"),
    );

    Circle dropOffLocCircle = Circle(
      fillColor: Colors.purple,
      center: pickUpLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.deepPurple,
      circleId: CircleId("dropOffID"),
    );

    setState(() {
      circlesSet.add(pickUpLocCircle);
      circlesSet.add(dropOffLocCircle);
    });

  }

  void initGeoFireLister() {
    // Geofire.initialize("availableDrivers");
    // //   Comment
    //
    // Geofire.queryAtLocation(currentPosition.latitude, currentPosition.longitude, 15).listen((map) {
    //   print(map);
    //   if (map != null) {
    //     var callBack = map['callBack'];
    //
    //     //latitude will be retrieved from map['latitude']
    //     //longitude will be retrieved from map['longitude']
    //
    //     switch (callBack) {
    //       case Geofire.onKeyEntered:
    //         NearbyAvailableDrivers nearbyAvailableDrivers = NearbyAvailableDrivers();
    //         nearbyAvailableDrivers.key = map['key'];
    //         nearbyAvailableDrivers.latitude = map['latitude'];
    //         nearbyAvailableDrivers.longitude = map['longitude'];
    //         GeoFireAssistant.nearbyAvailableDriversList.add(nearbyAvailableDrivers);
    //         if(nearbyAvailableDriverKeysloaded == true) {
    //           updateAvailableDriversOnMap();
    //         }
    //         break;
    //
    //       case Geofire.onKeyExited:
    //         GeoFireAssistant.removeDriverFromList(map['key']);
    //         updateAvailableDriversOnMap();
    //         break;
    //
    //       case Geofire.onKeyMoved:
    //         NearbyAvailableDrivers nearbyAvailableDrivers = NearbyAvailableDrivers();
    //         nearbyAvailableDrivers.key = map['key'];
    //         nearbyAvailableDrivers.latitude = map['latitude'];
    //         nearbyAvailableDrivers.longitude = map['longitude'];
    //         GeoFireAssistant.updateDriverNearbyLocation(nearbyAvailableDrivers);
    //         updateAvailableDriversOnMap();
    //         break;
    //
    //       case Geofire.onGeoQueryReady:
    //         updateAvailableDriversOnMap();
    //         break;
    //     }
    //   }
    //
    //   setState(() {});
    // });

    //   Comment
  }

  void updateAvailableDriversOnMap() {
    // setState(() {
    //   markersSet.clear();
    // });
    //
    // Set<Marker> tMarkers = Set<Marker>();
    // for(NearbyAvailableDrivers driver in GeoFireAssistant.nearbyAvailableDriversList) {
    //   LatLng dirverAvailablePosition = LatLng(driver.latitude, driver.longitude);
    //
    //   Marker marker = Marker(
    //     markerId: MarkerId('driver${driver.key}'),
    //     position: dirverAvailablePosition,
    //     icon: nearByIcon,
    //     rotation: AssistantMethods.createRandomNumber(360),
    //   );
    //
    //   tMarkers.add(marker);
    // }
    //
    // setState(() {
    //   markersSet = tMarkers;
    // });
  }

  void createIconMarker() {
    // if(nearByIcon == null) {
    //   ImageConfiguration imageConfiguration = createLocalImageConfiguration(context, size: Size(2, 2));
    //   BitmapDescriptor.fromAssetImage(imageConfiguration, "images/car_ios.png")
    //       .then((value) {
    //     nearByIcon = value;
    //   });
    // }
  }



  Future<void> getCurrentUserInfo() async {
    // // Users currentUser = Users();
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // MyApp.globalCurrentUser.id = pref.getString("current_user_id");
    // MyApp.globalCurrentUser.name = pref.get("current_user_name");
    // MyApp.globalCurrentUser.phone = pref.getString("current_user_phone");
    // MyApp.globalCurrentUser.email = pref.getString("current_user_email");
    //
    // print('****** GET CURRENT USER INFOS ************');
    // print('****** USER : ');
    // print(MyApp.globalCurrentUser.name);
    //
    // // pref.setBool("is_login", true);
    // // print('****** Les données ont été enregistré en local.');
    // // return currentUser;
  }

  Future<void> logoutUser() async {

    // SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.setBool("is_login", false);
    // print('****** Le conducteur a été déconnecter.');
  }

  // LatLng currentLocation = LatLng(0, 0);
  // Future<void> _getCurrentLocation() async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could show a dialog with
  //       // some explanation and a button to try again opening settings for this app
  //       return;
  //     }
  //   }
  //   Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   setState(() {
  //     currentLocation = LatLng(position.latitude, position.longitude);
  //   });
  // }

}
