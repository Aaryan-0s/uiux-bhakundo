// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_player_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouritePlayerApiModel _$FavouritePlayerApiModelFromJson(
        Map<String, dynamic> json) =>
    FavouritePlayerApiModel(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      playerId: json['playerId'] as String,
      playerName: json['playerName'] as String,
      photoUrl: json['photoUrl'] as String,
    );

Map<String, dynamic> _$FavouritePlayerApiModelToJson(
        FavouritePlayerApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'playerId': instance.playerId,
      'playerName': instance.playerName,
      'photoUrl': instance.photoUrl,
    };
