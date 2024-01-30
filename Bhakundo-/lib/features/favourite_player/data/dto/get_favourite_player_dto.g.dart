// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_favourite_player_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFavouritePlayerDTO _$GetFavouritePlayerDTOFromJson(
        Map<String, dynamic> json) =>
    GetFavouritePlayerDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              FavouritePlayerApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetFavouritePlayerDTOToJson(
        GetFavouritePlayerDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
