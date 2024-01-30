import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../config/constants/hive_table_constant.dart';
import '../../domain/entity/favourite_entity.dart';
import 'favourite_api_model.dart';

part 'favourite_hive_model.g.dart';

final favouriteHiveModelProvider = Provider(
  (ref) => const FavouriteHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.favouriteTableId)
class FavouriteHiveModel {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? userId;

  @HiveField(2)
  final String teamId;

  @HiveField(3)
  final String teamName;

  @HiveField(4)
  final String logoUrl;

  // empty constructor
  const FavouriteHiveModel.empty()
      : id = "",
        userId = '',
        teamId = '',
        teamName = '',
        logoUrl = '';

  FavouriteHiveModel({
    required this.id,
    required this.userId,
    required this.teamId,
    required this.teamName,
    required this.logoUrl,
  });

  // Convert Hive Object to Entity
  FavouriteEntity toEntity() => FavouriteEntity(
        id: id,
        userId: userId,
        teamId: teamId,
        teamName: teamName,
        logoUrl: logoUrl,
      );

  // Convert Entity to Hive Object
  FavouriteHiveModel toHiveModel(FavouriteEntity entity) => FavouriteHiveModel(
        id: id,
        userId: userId,
        teamId: teamId,
        teamName: teamName,
        logoUrl: logoUrl,
      );

  List<FavouriteHiveModel> fromApiModelList(List<FavouriteApiModel> apiModels) {
    return apiModels
        .map((apiModel) => FavouriteHiveModel(
            id: apiModel.id,
            userId: apiModel.userId,
            teamId: apiModel.teamId,
            teamName: apiModel.teamName,
            logoUrl: apiModel.logoUrl))
        .toList();
  }

  // Convert Hive List to Entity List
  List<FavouriteEntity> toEntityList(List<FavouriteHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'FavouriteHiveModel(id: $id, userId: $userId, teamId: $teamId, teamName: $teamName, logoUrl: $logoUrl)';
  }
}
