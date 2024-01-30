// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_player_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllPlayerDTO _$GetAllPlayerDTOFromJson(Map<String, dynamic> json) =>
    GetAllPlayerDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => PlayerApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllPlayerDTOToJson(GetAllPlayerDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
