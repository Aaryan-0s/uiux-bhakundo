// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_team_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllTeamDTO _$GetAllTeamDTOFromJson(Map<String, dynamic> json) =>
    GetAllTeamDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => TeamApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllTeamDTOToJson(GetAllTeamDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
