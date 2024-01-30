// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_standing_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllStandingDTO _$GetAllStandingDTOFromJson(Map<String, dynamic> json) =>
    GetAllStandingDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => StandingApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllStandingDTOToJson(GetAllStandingDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
