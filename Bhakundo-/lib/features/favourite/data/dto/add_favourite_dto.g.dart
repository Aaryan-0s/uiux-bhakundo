// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_favourite_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddFavouriteDTO _$AddFavouriteDTOFromJson(Map<String, dynamic> json) =>
    AddFavouriteDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => FavouriteApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddFavouriteDTOToJson(AddFavouriteDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
