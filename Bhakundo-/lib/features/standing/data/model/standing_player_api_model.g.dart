// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standing_player_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StandingPlayerApiModel _$StandingPlayerApiModelFromJson(
        Map<String, dynamic> json) =>
    StandingPlayerApiModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      team: json['team'] as String?,
      teamPicture: json['teamPicture'] as String?,
      goals: json['goals'] as int?,
      passes: json['passes'] as int?,
      games: json['games'] as int?,
      picture: json['picture'] as String?,
    );

Map<String, dynamic> _$StandingPlayerApiModelToJson(
        StandingPlayerApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'team': instance.team,
      'teamPicture': instance.teamPicture,
      'goals': instance.goals,
      'passes': instance.passes,
      'games': instance.games,
      'picture': instance.picture,
    };
