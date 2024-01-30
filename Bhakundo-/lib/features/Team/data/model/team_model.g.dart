// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamModel _$TeamModelFromJson(Map<String, dynamic> json) => TeamModel(
      forTotal:
          GoalTotalModel.fromJson(json['forTotal'] as Map<String, dynamic>),
      forAverage:
          GoalAverageModel.fromJson(json['forAverage'] as Map<String, dynamic>),
      forMinute: (json['forMinute'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, GoalMinuteModel.fromJson(e as Map<String, dynamic>)),
      ),
      againstTotal:
          GoalTotalModel.fromJson(json['againstTotal'] as Map<String, dynamic>),
      againstAverage: GoalAverageModel.fromJson(
          json['againstAverage'] as Map<String, dynamic>),
      againstMinute: (json['againstMinute'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, GoalMinuteModel.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$TeamModelToJson(TeamModel instance) => <String, dynamic>{
      'forTotal': instance.forTotal,
      'forAverage': instance.forAverage,
      'forMinute': instance.forMinute,
      'againstTotal': instance.againstTotal,
      'againstAverage': instance.againstAverage,
      'againstMinute': instance.againstMinute,
    };

GoalTotalModel _$GoalTotalModelFromJson(Map<String, dynamic> json) =>
    GoalTotalModel(
      home: json['home'] as int,
      away: json['away'] as int,
      total: json['total'] as int,
    );

Map<String, dynamic> _$GoalTotalModelToJson(GoalTotalModel instance) =>
    <String, dynamic>{
      'home': instance.home,
      'away': instance.away,
      'total': instance.total,
    };

GoalAverageModel _$GoalAverageModelFromJson(Map<String, dynamic> json) =>
    GoalAverageModel(
      home: (json['home'] as num).toDouble(),
      away: (json['away'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$GoalAverageModelToJson(GoalAverageModel instance) =>
    <String, dynamic>{
      'home': instance.home,
      'away': instance.away,
      'total': instance.total,
    };

GoalMinuteModel _$GoalMinuteModelFromJson(Map<String, dynamic> json) =>
    GoalMinuteModel(
      total: json['total'] as int,
      percentage: json['percentage'] as String,
    );

Map<String, dynamic> _$GoalMinuteModelToJson(GoalMinuteModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'percentage': instance.percentage,
    };
