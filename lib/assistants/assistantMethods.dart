import 'dart:math';


import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:depannagexpress/assistants/requestAssistant.dart';
import 'package:depannagexpress/data_handler/appData.dart';
import 'package:depannagexpress/models/address.dart';
import 'package:depannagexpress/models/directionDetails.dart';
import 'package:depannagexpress/config_maps.dart';
import 'package:provider/provider.dart';

class AssistantMethods {
  static Future<String> searchCoordinateAddress(Position position, context) async {

    String placeAddress = "";
    String st1, st2, st3, st4;
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${mapKey}";

    var response = await RequestAssistant.getRequest(url);

    if(response != "failed") {
      print('******* Yo le resultat : $response');
      //placeAddress = response["results"][0]["formatted_address"];
      //placeAddress = response["results"][0]["address_components"][3]["long_name"];
      // st1 = response["results"][0]["address_components"][0]["long_name"];
      // st2 = response["results"][0]["address_components"][1]["long_name"];
      // st3 = response["results"][0]["address_components"][3]["long_name"];
      // st4 = response["results"][0]["address_components"][4]["long_name"];

      st1 = response["results"][0]["address_components"][1]["long_name"];
      st2 = response["results"][0]["address_components"][2]["long_name"];
      st3 = response["results"][0]["address_components"][3]["long_name"];




      // placeAddress = st1 + ", " + st2 + ", " + st3 + ", " + st4;
     placeAddress = st1 + ", " + st2 + ", " + st3;


      Address userPickUpAddress = new Address();
      userPickUpAddress.longitude = position.longitude;
      userPickUpAddress.latitude = position.latitude;
      userPickUpAddress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false).updatePickUpLocationAddress(userPickUpAddress);
    }

    return placeAddress;

  }

  //static Future<DirectionDetails> obtainPlaceDirectionDetails(LatLng initialPosition, LatLng finalPosition) async {
  static Future<dynamic> obtainPlaceDirectionDetails(LatLng initialPosition, LatLng finalPosition) async {


    print("********************* Les Positions :: ");
    print(initialPosition);
    print(finalPosition);

    String directionUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$mapKey";

    var res = await RequestAssistant.getRequest(directionUrl);

    if(res == "failed") {
      return null;
    }

    print("********************* Le resultat  : ");
    print(res);

    DirectionDetails directionDetails = DirectionDetails();
    // var encPt = res["routes"][0]["overview_polyline"]["points"];
    // print("********************* encodedPoints : ");
    // print(encPt);
    directionDetails.encodedPoints =  res["routes"][0]["overview_polyline"]["points"];

    directionDetails.distanceText =  res["routes"][0]["legs"][0]["distance"]["text"];
    directionDetails.distanceValue =  res["routes"][0]["legs"][0]["distance"]["value"];

    directionDetails.durationText =  res["routes"][0]["legs"][0]["duration"]["text"];
    directionDetails.durationValue =  res["routes"][0]["legs"][0]["duration"]["value"];

    return directionDetails;
  }

  static int calculateFares(DirectionDetails directionDetails) {
    // in terms USD
    double timeTraveledFare = (directionDetails.durationValue! / 60) * 0.20;
    double distanceTraveledFare = (directionDetails.distanceValue! / 1000) * 0.20;
    double totalFareAmount = timeTraveledFare + distanceTraveledFare;

    // 1$ = 550 FCFA
    // double totalLocalAmount = totalFareAmount * 550;

    return totalFareAmount.truncate();
  }

  static void getCurrentOnLineUserInfo() async {
    // firebaseUser = await FirebaseAuth.instance.currentUser;
    // String userId = firebaseUser.uid;
    // DatabaseReference reference = FirebaseDatabase.instance.reference().child("users").child(userId);
    //
    // reference.once().then((DataSnapshot dataSnapshot) {
    //   if(dataSnapshot.value != null) {
    //     userCurrentInfo = Users.fromSnapshot(dataSnapshot);
    //   }
    // });
  }

  static double createRandomNumber(int num) {
    var random = Random();
    int randNumber = random.nextInt(num);
    return randNumber.toDouble();
  }

}