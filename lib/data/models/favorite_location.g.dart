// GENERATED CODE - DO NOT MODIFY BY HAND
// Manual Hive TypeAdapter for FavoriteLocation

part of 'favorite_location.dart';

class FavoriteLocationAdapter extends TypeAdapter<FavoriteLocation> {
  @override
  final int typeId = 0;

  @override
  FavoriteLocation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteLocation(
      id: fields[0] as String,
      name: fields[1] as String,
      latitude: fields[2] as double,
      longitude: fields[3] as double,
      country: fields[4] as String?,
      admin1: fields[5] as String?,
      timezone: fields[6] as String?,
      addedAt: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteLocation obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.latitude)
      ..writeByte(3)
      ..write(obj.longitude)
      ..writeByte(4)
      ..write(obj.country)
      ..writeByte(5)
      ..write(obj.admin1)
      ..writeByte(6)
      ..write(obj.timezone)
      ..writeByte(7)
      ..write(obj.addedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteLocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
