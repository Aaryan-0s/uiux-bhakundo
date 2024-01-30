// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_fixture_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFixtureInfoDTO _$GetFixtureInfoDTOFromJson(Map<String, dynamic> json) =>
    GetFixtureInfoDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => FixtureInfoApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetFixtureInfoDTOToJson(GetFixtureInfoDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
