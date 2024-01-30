// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standing_player_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StandingPlayerHiveModelAdapter
    extends TypeAdapter<StandingPlayerHiveModel> {
  @override
  final int typeId = 2;

  @override
  StandingPlayerHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StandingPlayerHiveModel(
      id: fields[0] as int?,
      name: fields[1] as String?,
      team: fields[3] as String?,
      teamPicture: fields[4] as String?,
      goals: fields[5] as int?,
      passes: fields[6] as int?,
      games: fields[7] as int?,
      picture: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StandingPlayerHiveModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.team)
      ..writeByte(4)
      ..write(obj.teamPicture)
      ..writeByte(5)
      ..write(obj.goals)
      ..writeByte(6)
      ..write(obj.passes)
      ..writeByte(7)
      ..write(obj.games)
      ..writeByte(8)
      ..write(obj.picture);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StandingPlayerHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
