// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchModel _$MatchModelFromJson(Map<String, dynamic> json) => MatchModel(
      fixtureId: json['fixtureId'] as int?,
      homeTeamLogo: json['homeTeamLogo'] as String,
      homeTeam: json['homeTeam'] as String,
      awayTeamLogo: json['awayTeamLogo'] as String,
      awayTeam: json['awayTeam'] as String,
      score: json['score'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$MatchModelToJson(MatchModel instance) =>
    <String, dynamic>{
      'fixtureId': instance.fixtureId,
      'homeTeamLogo': instance.homeTeamLogo,
      'homeTeam': instance.homeTeam,
      'awayTeamLogo': instance.awayTeamLogo,
      'awayTeam': instance.awayTeam,
      'score': instance.score,
      'status': instance.status,
    };
