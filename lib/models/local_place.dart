import 'package:hive/hive.dart';

part 'local_place.g.dart';

@HiveType(typeId: 0)
class LocalPlace extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? city;

  @HiveField(3)
  String? description;

  @HiveField(4)
  String? imageLink;
}
