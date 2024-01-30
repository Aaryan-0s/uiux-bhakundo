// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_standing_player_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllStandingPlayerDTO _$GetAllStandingPlayerDTOFromJson(
        Map<String, dynamic> json) =>
    GetAllStandingPlayerDTO(
      data: (json['data'] as List<dynamic>)
          .map(
              (e) => StandingPlayerApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllStandingPlayerDTOToJson(
        GetAllStandingPlayerDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
