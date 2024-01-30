// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProfileDTO _$GetProfileDTOFromJson(Map<String, dynamic> json) =>
    GetProfileDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => ProfileApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetProfileDTOToJson(GetProfileDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
