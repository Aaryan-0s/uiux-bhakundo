// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_games_by_date_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllGameByDateDTO _$GetAllGameByDateDTOFromJson(Map<String, dynamic> json) =>
    GetAllGameByDateDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => GameApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllGameByDateDTOToJson(
        GetAllGameByDateDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
