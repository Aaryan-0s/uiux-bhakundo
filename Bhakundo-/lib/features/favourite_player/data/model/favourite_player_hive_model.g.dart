// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_player_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouritePlayerHiveModelAdapter
    extends TypeAdapter<FavouritePlayerHiveModel> {
  @override
  final int typeId = 4;

  @override
  FavouritePlayerHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavouritePlayerHiveModel(
      id: fields[0] as String?,
      userId: fields[1] as String?,
      playerId: fields[2] as String,
      playerName: fields[3] as String,
      photoUrl: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavouritePlayerHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.playerId)
      ..writeByte(3)
      ..write(obj.playerName)
      ..writeByte(4)
      ..write(obj.photoUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouritePlayerHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
