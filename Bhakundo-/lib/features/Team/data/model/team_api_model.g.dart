// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamApiModel _$TeamApiModelFromJson(Map<String, dynamic> json) => TeamApiModel(
      datumFor: ForAgainst.fromJson(json['for'] as Map<String, dynamic>),
      against: ForAgainst.fromJson(json['against'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TeamApiModelToJson(TeamApiModel instance) =>
    <String, dynamic>{
      'for': instance.datumFor,
      'against': instance.against,
    };
