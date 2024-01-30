// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_game_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllGameDTO _$GetAllGameDTOFromJson(Map<String, dynamic> json) =>
    GetAllGameDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => GameApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllGameDTOToJson(GetAllGameDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
