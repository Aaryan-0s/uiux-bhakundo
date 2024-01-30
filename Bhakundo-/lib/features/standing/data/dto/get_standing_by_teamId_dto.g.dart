// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_standing_by_teamId_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetStandingByTeamIdDTO _$GetStandingByTeamIdDTOFromJson(
        Map<String, dynamic> json) =>
    GetStandingByTeamIdDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => StandingApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetStandingByTeamIdDTOToJson(
        GetStandingByTeamIdDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
