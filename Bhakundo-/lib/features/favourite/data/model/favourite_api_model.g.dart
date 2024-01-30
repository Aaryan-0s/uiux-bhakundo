// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouriteApiModel _$FavouriteApiModelFromJson(Map<String, dynamic> json) =>
    FavouriteApiModel(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      teamId: json['teamId'] as String,
      teamName: json['teamName'] as String,
      logoUrl: json['logoUrl'] as String,
    );

Map<String, dynamic> _$FavouriteApiModelToJson(FavouriteApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'logoUrl': instance.logoUrl,
    };
