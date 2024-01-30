import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:nba_hub/features/standing/data/model/standing_player_api_model.dart';

import '../../../../config/constants/hive_table_constant.dart';
import '../../domain/entity/standing_player_entity.dart';

part 'standing_player_hive_model.g.dart';

final standingPlayerHiveModelProvider = Provider(
  (ref) => const StandingPlayerHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.standingPlayerTableId)
class StandingPlayerHiveModel {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? name;

  @HiveField(3)
  final String? team;

  @HiveField(4)
  final String? teamPicture;

  @HiveField(5)
  final int? goals;

  @HiveField(6)
  final int? passes;

  @HiveField(7)
  final int? games;

  @HiveField(8)
  final String? picture;

  // empty constructor
  const StandingPlayerHiveModel.empty()
      : id = 0,
        name = '',
        team = '',
        teamPicture = "",
        goals = 0,
        passes = 0,
        games = 0,
        picture = "";

  const StandingPlayerHiveModel({
    required this.id,
    required this.name,
    required this.team,
    required this.teamPicture,
    required this.goals,
    required this.passes,
    required this.games,
    required this.picture,
  });

  // Convert Hive Object to Entity
  StandingPlayerEntity toEntity() => StandingPlayerEntity(
        id: id!,
        name: name!,
        team: team!,
        teamPicture: teamPicture!,
        goals: goals!,
        passes: passes!,
        games: games!,
        picture: picture!,
      );

  // Convert Entity to Hive Object
  StandingPlayerHiveModel toHiveModel(StandingPlayerEntity entity) =>
      StandingPlayerHiveModel(
        id: entity.id,
        name: entity.name,
        team: entity.team,
        teamPicture: entity.teamPicture,
        goals: entity.goals,
        passes: entity.passes,
        games: entity.games,
        picture: entity.picture,
      );
  List<StandingPlayerHiveModel> fromApiModelList(
      List<StandingPlayerApiModel> apiModels) {
    return apiModels
        .map((apiModel) => StandingPlayerHiveModel(
              id: apiModel.id,
              name: apiModel.name,
              team: apiModel.team,
              teamPicture: apiModel.teamPicture,
              goals: apiModel.goals,
              passes: apiModel.passes,
              games: apiModel.games,
              picture: apiModel.picture,
            ))
        .toList();
  }

  // Convert Hive List to Entity List
  List<StandingPlayerEntity> toEntityList(
          List<StandingPlayerHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'StandingPlayerHiveModel(id: $id, name: $name, team: $team, teamPicture: $teamPicture, goals: $goals, passes: $passes, games: $games, picture: $picture)';
  }
}
