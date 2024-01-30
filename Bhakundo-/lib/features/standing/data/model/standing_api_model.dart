import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/standing_entity.dart';

part 'standing_api_model.g.dart';

final standingApiModelProvider = Provider<StandingApiModel>(
  (ref) => const StandingApiModel.empty(),
);

@JsonSerializable()
class StandingApiModel extends Equatable {
  @JsonKey(name: 'rank')
  final int rank;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'logo')
  final String logo;
  @JsonKey(name: 'points')
  final int points;
  @JsonKey(name: 'goalsDiff')
  final int goalsDiff;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'played')
  final int played;
  @JsonKey(name: 'win')
  final int win;
  @JsonKey(name: 'draw')
  final int draw;
  @JsonKey(name: 'lose')
  final int lose;
  @JsonKey(name: 'goalsFor')
  final int goalsFor;
  @JsonKey(name: 'goalsAgainst')
  final int goalsAgainst;

  const StandingApiModel({
    required this.rank,
    required this.id,
    required this.name,
    required this.logo,
    required this.points,
    required this.goalsDiff,
    required this.status,
    required this.played,
    required this.win,
    required this.draw,
    required this.lose,
    required this.goalsFor,
    required this.goalsAgainst,
  });

  const StandingApiModel.empty()
      : rank = 0,
        id = 0,
        name = '',
        logo = '',
        points = 0,
        goalsDiff = 0,
        status = '',
        played = 0,
        win = 0,
        draw = 0,
        lose = 0,
        goalsFor = 0,
        goalsAgainst = 0;

  Map<String, dynamic> toJson() => _$StandingApiModelToJson(this);

  factory StandingApiModel.fromJson(Map<String, dynamic> json) =>
      _$StandingApiModelFromJson(json);

  StandingEntity toEntity() => StandingEntity(
        rank: rank,
        id: id,
        name: name,
        logo: logo,
        points: points,
        goalsDiff: goalsDiff,
        status: status,
        played: played,
        win: win,
        draw: draw,
        lose: lose,
        goalsFor: goalsFor,
        goalsAgainst: goalsAgainst,
      );

  StandingApiModel fromEntity(StandingEntity entity) => StandingApiModel(
        rank: entity.rank,
        id: entity.id,
        name: entity.name,
        logo: entity.logo,
        points: entity.points,
        goalsDiff: entity.goalsDiff,
        status: entity.status,
        played: entity.played,
        win: entity.win,
        draw: entity.draw,
        lose: entity.lose,
        goalsFor: entity.goalsFor,
        goalsAgainst: entity.goalsAgainst,
      );

  List<StandingEntity> toEntityList(List<StandingApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        rank,
        id,
        name,
        logo,
        points,
        goalsDiff,
        status,
        played,
        win,
        draw,
        lose,
        goalsFor,
        goalsAgainst,
      ];
}
