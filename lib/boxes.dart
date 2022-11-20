import 'package:hive/hive.dart';
import 'package:travelapp/models/local_place.dart';

class Boxes {
  static Box<LocalPlace> getFavoritesBox() => Hive.box<LocalPlace>('favorites');
}
