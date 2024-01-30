// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerApiModel _$PlayerApiModelFromJson(Map<String, dynamic> json) =>
    PlayerApiModel(
      player: Player.fromJson(json['player'] as Map<String, dynamic>),
      statistics: (json['statistics'] as List<dynamic>)
          .map((e) => Statistic.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlayerApiModelToJson(PlayerApiModel instance) =>
    <String, dynamic>{
      'player': instance.player,
      'statistics': instance.statistics,
    };
