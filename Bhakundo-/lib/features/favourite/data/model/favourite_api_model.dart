import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/favourite_entity.dart';

part 'favourite_api_model.g.dart';

final favouriteApiModelProvider = Provider<FavouriteApiModel>((ref) {
  return const FavouriteApiModel.empty();
});

@JsonSerializable()
class FavouriteApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'userId')
  final String? userId;
  @JsonKey(name: 'teamId')
  final String teamId;
  @JsonKey(name: 'teamName')
  final String teamName;
  @JsonKey(name: 'logoUrl')
  final String logoUrl;

  const FavouriteApiModel({
    this.id,
    this.userId,
    required this.teamId,
    required this.teamName,
    required this.logoUrl,
  });
  const FavouriteApiModel.empty()
      : id = '',
        userId = '',
        teamId = '',
        teamName = '',
        logoUrl = '';

  FavouriteEntity toEntity() => FavouriteEntity(
        id: id,
        userId: userId,
        teamId: teamId,
        teamName: teamName,
        logoUrl: logoUrl,
      );

  FavouriteApiModel fromEntity(FavouriteEntity entity) => FavouriteApiModel(
        id: id,
        userId: userId,
        teamId: teamId,
        teamName: teamName,
        logoUrl: logoUrl,
      );

  List<FavouriteEntity> toEntityList(List<FavouriteApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  Map<String, dynamic> toJson() => _$FavouriteApiModelToJson(this);

  factory FavouriteApiModel.fromJson(Map<String, dynamic> json) =>
      _$FavouriteApiModelFromJson(json);

  @override
  // TODO: implement props
  List<Object?> get props => [id, userId, teamId, teamName, logoUrl];
}
