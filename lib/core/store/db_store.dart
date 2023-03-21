import 'package:hive/hive.dart';

class HiveDb {
  Future<Box> openBox(String boxName) {
    return Hive.openBox(boxName);
  }
}
