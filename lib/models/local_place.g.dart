// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_place.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalPlaceAdapter extends TypeAdapter<LocalPlace> {
  @override
  final int typeId = 0;

  @override
  LocalPlace read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalPlace()
      ..id = fields[0] as String?
      ..name = fields[1] as String?
      ..city = fields[2] as String?
      ..type = fields[3] as String?
      ..imageLink = fields[4] as String?;
  }

  @override
  void write(BinaryWriter writer, LocalPlace obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.city)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.imageLink);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalPlaceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
