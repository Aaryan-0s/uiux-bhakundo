// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixture_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FixtureModel _$FixtureModelFromJson(Map<String, dynamic> json) => FixtureModel(
      name: json['name'] as String?,
      shotsOnGoal: json['shotsOnGoal'] as int,
      shotsOffGoal: json['shotsOffGoal'] as int,
      totalShots: json['totalShots'] as int,
      blockedShots: json['blockedShots'] as int,
      shotsInsideBox: json['shotsInsideBox'] as int,
      shotsOutsideBox: json['shotsOutsideBox'] as int,
      fouls: json['fouls'] as int,
      cornerKicks: json['cornerKicks'] as int,
      offsides: json['offsides'] as int,
      ballPossession: json['ballPossession'] as String,
    );

Map<String, dynamic> _$FixtureModelToJson(FixtureModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'shotsOnGoal': instance.shotsOnGoal,
      'shotsOffGoal': instance.shotsOffGoal,
      'totalShots': instance.totalShots,
      'blockedShots': instance.blockedShots,
      'shotsInsideBox': instance.shotsInsideBox,
      'shotsOutsideBox': instance.shotsOutsideBox,
      'fouls': instance.fouls,
      'cornerKicks': instance.cornerKicks,
      'offsides': instance.offsides,
      'ballPossession': instance.ballPossession,
    };
