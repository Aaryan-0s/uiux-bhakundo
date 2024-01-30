// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameHiveModelAdapter extends TypeAdapter<GameHiveModel> {
  @override
  final int typeId = 0;

  @override
  GameHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameHiveModel(
      fixtureId: fields[0] as int,
      homeTeamLogo: fields[1] as String,
      homeTeam: fields[2] as String,
      awayTeamLogo: fields[3] as String,
      awayTeam: fields[4] as String,
      score: fields[5] as String,
      status: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GameHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.fixtureId)
      ..writeByte(1)
      ..write(obj.homeTeamLogo)
      ..writeByte(2)
      ..write(obj.homeTeam)
      ..writeByte(3)
      ..write(obj.awayTeamLogo)
      ..writeByte(4)
      ..write(obj.awayTeam)
      ..writeByte(5)
      ..write(obj.score)
      ..writeByte(6)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
