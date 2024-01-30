import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../config/constants/hive_table_constant.dart';
import '../../domain/entity/favourite_entity.dart';
import 'favourite_player_api_model.dart';

part 'favourite_player_hive_model.g.dart';

final favouritePlayerHiveModelProvider = Provider(
  (ref) => const FavouritePlayerHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.favouritePlayerTableId)
class FavouritePlayerHiveModel {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? userId;

  @HiveField(2)
  final String playerId;

  @HiveField(3)
  final String playerName;

  @HiveField(4)
  final String photoUrl;

  // empty constructor
  const FavouritePlayerHiveModel.empty()
      : id = "",
        userId = '',
        playerId = '',
        playerName = '',
        photoUrl = '';

  FavouritePlayerHiveModel({
    required this.id,
    required this.userId,
    required this.playerId,
    required this.playerName,
    required this.photoUrl,
  });

  // Convert Hive Object to Entity
  FavouritePlayerEntity toEntity() => FavouritePlayerEntity(
        id: id,
        userId: userId,
        playerId: playerId,
        playerName: playerName,
        photoUrl: photoUrl,
      );

  // Convert Entity to Hive Object
  FavouritePlayerHiveModel toHiveModel(FavouritePlayerEntity entity) =>
      FavouritePlayerHiveModel(
        id: id,
        userId: userId,
        playerId: playerId,
        playerName: playerName,
        photoUrl: photoUrl,
      );

  List<FavouritePlayerHiveModel> fromApiModelList(
      List<FavouritePlayerApiModel> apiModels) {
    return apiModels
        .map((apiModel) => FavouritePlayerHiveModel(
              id: apiModel.id,
              userId: apiModel.userId,
              playerId: apiModel.playerId,
              playerName: apiModel.playerName,
              photoUrl: apiModel.photoUrl,
            ))
        .toList();
  }

  // Convert Hive List to Entity List
  List<FavouritePlayerEntity> toEntityList(
          List<FavouritePlayerHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'FavouritePlayerHiveModel(id: $id, userId: $userId, playerId: $playerId, playerName: $playerName, photoUrl: $photoUrl)';
  }
}
