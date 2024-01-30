// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standing_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StandingApiModel _$StandingApiModelFromJson(Map<String, dynamic> json) =>
    StandingApiModel(
      rank: json['rank'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      logo: json['logo'] as String,
      points: json['points'] as int,
      goalsDiff: json['goalsDiff'] as int,
      status: json['status'] as String,
      played: json['played'] as int,
      win: json['win'] as int,
      draw: json['draw'] as int,
      lose: json['lose'] as int,
      goalsFor: json['goalsFor'] as int,
      goalsAgainst: json['goalsAgainst'] as int,
    );

Map<String, dynamic> _$StandingApiModelToJson(StandingApiModel instance) =>
    <String, dynamic>{
      'rank': instance.rank,
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'points': instance.points,
      'goalsDiff': instance.goalsDiff,
      'status': instance.status,
      'played': instance.played,
      'win': instance.win,
      'draw': instance.draw,
      'lose': instance.lose,
      'goalsFor': instance.goalsFor,
      'goalsAgainst': instance.goalsAgainst,
    };
