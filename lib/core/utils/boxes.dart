import 'package:hive_flutter/hive_flutter.dart';

class HiveBoxes{
  static Box getUserData()=>Hive.box("userInfo");

}