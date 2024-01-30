import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:nba_hub/features/standing/data/model/standing_api_model.dart';

import '../../../../config/constants/hive_table_constant.dart';
import '../../domain/entity/standing_entity.dart';

part 'standing_hive_model.g.dart';

final standingHiveModelProvider = Provider(
  (ref) => const StandingHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.standingTeamTableId)
class StandingHiveModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int rank;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String logo;

  @HiveField(4)
  final int points;

  @HiveField(5)
  final int goalsDiff;

  @HiveField(6)
  final String status;

  @HiveField(7)
  final int played;

  @HiveField(8)
  final int win;

  @HiveField(9)
  final int lose;

  @HiveField(10)
  final int draw;

  @HiveField(11)
  final int goalsFor;
  @HiveField(12)
  final int goalsAgainst;

  // empty constructor
  const StandingHiveModel.empty()
      : id = 0,
        rank = 0,
        name = '',
        logo = '',
        points = 0,
        goalsDiff = 0,
        status = "",
        played = 0,
        win = 0,
        lose = 0,
        draw = 0,
        goalsFor = 0,
        goalsAgainst = 0;

  const StandingHiveModel({
    required this.id,
    required this.rank,
    required this.name,
    required this.logo,
    required this.points,
    required this.goalsDiff,
    required this.status,
    required this.played,
    required this.win,
    required this.lose,
    required this.draw,
    required this.goalsFor,
    required this.goalsAgainst,
  });

  // Convert Hive Object to Entity
  StandingEntity toEntity() => StandingEntity(
        id: id,
        rank: rank,
        name: name,
        logo: logo,
        points: points,
        goalsDiff: goalsDiff,
        status: status,
        played: played,
        win: win,
        lose: lose,
        draw: draw,
        goalsFor: goalsFor,
        goalsAgainst: goalsAgainst,
      );

  // Convert Entity to Hive Object
  StandingHiveModel toHiveModel(StandingEntity entity) => StandingHiveModel(
        id: entity.id,
        rank: entity.rank,
        name: entity.name,
        logo: entity.logo,
        points: entity.points,
        goalsDiff: entity.goalsDiff,
        status: entity.status,
        played: entity.played,
        win: entity.win,
        lose: entity.lose,
        draw: entity.draw,
        goalsFor: entity.goalsFor,
        goalsAgainst: entity.goalsAgainst,
      );
  List<StandingHiveModel> fromApiModelList(List<StandingApiModel> apiModels) {
    return apiModels
        .map((apiModel) => StandingHiveModel(
              id: apiModel.id,
              rank: apiModel.rank,
              name: apiModel.name,
              logo: apiModel.logo,
              points: apiModel.points,
              goalsDiff: apiModel.goalsDiff,
              status: apiModel.status,
              played: apiModel.played,
              win: apiModel.win,
              lose: apiModel.lose,
              draw: apiModel.draw,
              goalsFor: apiModel.goalsFor,
              goalsAgainst: apiModel.goalsAgainst,
            ))
        .toList();
  }

  // Convert Hive List to Entity List
  List<StandingEntity> toEntityList(List<StandingHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'StandingHiveModel(id: $id, rank: $rank, name: $name, logo: $logo, points: $points, goalsDiff: $goalsDiff, status: $status, played: $played, win: $win, lose: $lose, draw: $draw, goalsFor: $goalsFor, goalsAgainst: $goalsAgainst)';
  }
}
