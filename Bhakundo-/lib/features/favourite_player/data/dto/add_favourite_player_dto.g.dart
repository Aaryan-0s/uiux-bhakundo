// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_favourite_player_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddFavouritePlayerDTO _$AddFavouritePlayerDTOFromJson(
        Map<String, dynamic> json) =>
    AddFavouritePlayerDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              FavouritePlayerApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddFavouritePlayerDTOToJson(
        AddFavouritePlayerDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
