// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_player_by_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllPlayerByIdDTO _$GetAllPlayerByIdDTOFromJson(Map<String, dynamic> json) =>
    GetAllPlayerByIdDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => PlayerApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllPlayerByIdDTOToJson(
        GetAllPlayerByIdDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
