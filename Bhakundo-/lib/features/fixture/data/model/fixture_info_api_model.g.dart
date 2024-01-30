// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixture_info_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FixtureInfoApiModel _$FixtureInfoApiModelFromJson(Map<String, dynamic> json) =>
    FixtureInfoApiModel(
      fixtureId: json['fixtureId'] as int,
      status: json['status'] as String,
      homeTeam: json['homeTeam'] as String,
      homeTeamLogo: json['homeTeamLogo'] as String,
      awayTeam: json['awayTeam'] as String,
      awayTeamLogo: json['awayTeamLogo'] as String,
      score: json['score'] as String,
    );

Map<String, dynamic> _$FixtureInfoApiModelToJson(
        FixtureInfoApiModel instance) =>
    <String, dynamic>{
      'fixtureId': instance.fixtureId,
      'status': instance.status,
      'homeTeam': instance.homeTeam,
      'homeTeamLogo': instance.homeTeamLogo,
      'awayTeam': instance.awayTeam,
      'awayTeamLogo': instance.awayTeamLogo,
      'score': instance.score,
    };
