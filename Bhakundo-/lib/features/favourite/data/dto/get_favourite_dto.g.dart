// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_favourite_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFavouriteDTO _$GetFavouriteDTOFromJson(Map<String, dynamic> json) =>
    GetFavouriteDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => FavouriteApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetFavouriteDTOToJson(GetFavouriteDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
