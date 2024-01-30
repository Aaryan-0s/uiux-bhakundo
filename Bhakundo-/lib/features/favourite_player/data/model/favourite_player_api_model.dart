import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/favourite_entity.dart';

part 'favourite_player_api_model.g.dart';

final favouritePlayerApiModelProvider =
    Provider<FavouritePlayerApiModel>((ref) {
  return const FavouritePlayerApiModel.empty();
});

@JsonSerializable()
class FavouritePlayerApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'userId')
  final String? userId;
  @JsonKey(name: 'playerId')
  final String playerId;
  @JsonKey(name: 'playerName')
  final String playerName;
  @JsonKey(name: 'photoUrl')
  final String photoUrl;

  const FavouritePlayerApiModel({
    this.id,
    this.userId,
    required this.playerId,
    required this.playerName,
    required this.photoUrl,
  });
  const FavouritePlayerApiModel.empty()
      : id = '',
        userId = '',
        playerId = '',
        playerName = '',
        photoUrl = '';

  FavouritePlayerEntity toEntity() => FavouritePlayerEntity(
        id: id,
        userId: userId,
        playerId: playerId,
        playerName: playerName,
        photoUrl: photoUrl,
      );

  FavouritePlayerApiModel fromEntity(FavouritePlayerEntity entity) =>
      FavouritePlayerApiModel(
        id: id,
        userId: userId,
        playerId: playerId,
        playerName: playerName,
        photoUrl: photoUrl,
      );

  List<FavouritePlayerEntity> toEntityList(
          List<FavouritePlayerApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  Map<String, dynamic> toJson() => _$FavouritePlayerApiModelToJson(this);

  factory FavouritePlayerApiModel.fromJson(Map<String, dynamic> json) =>
      _$FavouritePlayerApiModelFromJson(json);

  @override
  // TODO: implement props
  List<Object?> get props => [id, userId, playerId, playerName, photoUrl];
}
