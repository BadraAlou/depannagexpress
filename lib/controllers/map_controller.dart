
import 'package:get/get.dart';

class MapController extends GetxController {
  Rx<int> currentDistanceValue = Rx<int>(0);
  Rx<num> distanceMyPositionToGarage = Rx<num>(0.0);
  Rx<String> distanceMyPositionToGarageText = Rx<String>('');
  Rx<bool> isLocate = Rx<bool>(false);
  Rx<String> currentDistanceText = Rx<String>('');
  //Rx<String> typeRemorquage = Rx<String>('');
  Rx<int> typeRemorquage = Rx<int>(0);


}