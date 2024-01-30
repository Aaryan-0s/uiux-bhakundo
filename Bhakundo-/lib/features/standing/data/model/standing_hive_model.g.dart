// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standing_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StandingHiveModelAdapter extends TypeAdapter<StandingHiveModel> {
  @override
  final int typeId = 1;

  @override
  StandingHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StandingHiveModel(
      id: fields[0] as int,
      rank: fields[1] as int,
      name: fields[2] as String,
      logo: fields[3] as String,
      points: fields[4] as int,
      goalsDiff: fields[5] as int,
      status: fields[6] as String,
      played: fields[7] as int,
      win: fields[8] as int,
      lose: fields[9] as int,
      draw: fields[10] as int,
      goalsFor: fields[11] as int,
      goalsAgainst: fields[12] as int,
    );
  }

  @override
  void write(BinaryWriter writer, StandingHiveModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.rank)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.logo)
      ..writeByte(4)
      ..write(obj.points)
      ..writeByte(5)
      ..write(obj.goalsDiff)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.played)
      ..writeByte(8)
      ..write(obj.win)
      ..writeByte(9)
      ..write(obj.lose)
      ..writeByte(10)
      ..write(obj.draw)
      ..writeByte(11)
      ..write(obj.goalsFor)
      ..writeByte(12)
      ..write(obj.goalsAgainst);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StandingHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
