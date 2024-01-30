// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_fixture_by_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFixtureByIdDTO _$GetFixtureByIdDTOFromJson(Map<String, dynamic> json) =>
    GetFixtureByIdDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => FixtureApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetFixtureByIdDTOToJson(GetFixtureByIdDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
