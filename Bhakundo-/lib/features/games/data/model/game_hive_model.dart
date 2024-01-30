import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nba_hub/config/constants/hive_table_constant.dart';
import 'package:nba_hub/features/games/data/model/game_api_model.dart';
import 'package:nba_hub/features/games/domain/entity/game_entity.dart';

part 'game_hive_model.g.dart';

final gameHiveModelProvider = Provider(
  (ref) => const GameHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.gameTableId)
class GameHiveModel {
  @HiveField(0)
  final int fixtureId;

  @HiveField(1)
  final String homeTeamLogo;

  @HiveField(2)
  final String homeTeam;

  @HiveField(3)
  final String awayTeamLogo;

  @HiveField(4)
  final String awayTeam;

  @HiveField(5)
  final String score;

  @HiveField(6)
  final String status;

  // empty constructor
  const GameHiveModel.empty()
      : fixtureId = 0,
        homeTeamLogo = '',
        homeTeam = '',
        awayTeamLogo = '',
        awayTeam = '',
        score = '',
        status = '';

  GameHiveModel({
    required this.fixtureId,
    required this.homeTeamLogo,
    required this.homeTeam,
    required this.awayTeamLogo,
    required this.awayTeam,
    required this.score,
    required this.status,
  });

  // Convert Hive Object to Entity
  GameEntity toEntity() => GameEntity(
        fixtureId: fixtureId,
        homeTeamLogo: homeTeamLogo,
        homeTeam: homeTeam,
        awayTeamLogo: awayTeamLogo,
        awayTeam: awayTeam,
        score: score,
        status: status,
      );

  // Convert Entity to Hive Object
  GameHiveModel toHiveModel(GameEntity entity) => GameHiveModel(
        fixtureId: entity.fixtureId,
        homeTeamLogo: entity.homeTeamLogo,
        homeTeam: entity.homeTeam,
        awayTeamLogo: entity.awayTeamLogo,
        awayTeam: entity.awayTeam,
        score: entity.score,
        status: entity.status,
      );
  List<GameHiveModel> fromApiModelList(List<GameApiModel> apiModels) {
    return apiModels
        .map((apiModel) => GameHiveModel(
              fixtureId: apiModel.fixtureId,
              homeTeamLogo: apiModel.homeTeamLogo,
              homeTeam: apiModel.homeTeam,
              awayTeamLogo: apiModel.awayTeamLogo,
              awayTeam: apiModel.awayTeam,
              score: apiModel.score,
              status: apiModel.status,
            ))
        .toList();
  }

  // Convert Hive List to Entity List
  List<GameEntity> toEntityList(List<GameHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'GameHiveModel(fixtureId: $fixtureId, homeTeamLogo: $homeTeamLogo, homeTeam: $homeTeam, awayTeamLogo: $awayTeamLogo, awayTeam: $awayTeam, score: $score, status: $status)';
  }
}
