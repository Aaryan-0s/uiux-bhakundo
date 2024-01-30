import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/game_entity.dart';

part 'game_api_model.g.dart';

final gameApiModelProvider = Provider<GameApiModel>(
  (ref) => const GameApiModel.empty(),
);

@JsonSerializable()
class GameApiModel extends Equatable {
  @JsonKey(name: 'fixtureId')
  final int fixtureId;
  @JsonKey(name: 'homeTeamLogo')
  final String homeTeamLogo;
  @JsonKey(name: 'homeTeam')
  final String homeTeam;
  @JsonKey(name: 'awayTeamLogo')
  final String awayTeamLogo;
  @JsonKey(name: 'awayTeam')
  final String awayTeam;
  @JsonKey(name: 'score')
  final String score;
  @JsonKey(name: 'status')
  final String status;

  const GameApiModel({
    required this.fixtureId,
    required this.homeTeamLogo,
    required this.homeTeam,
    required this.awayTeamLogo,
    required this.awayTeam,
    required this.score,
    required this.status,
  });
  const GameApiModel.empty()
      : fixtureId = 0,
        homeTeamLogo = '',
        homeTeam = '',
        awayTeamLogo = '',
        awayTeam = '',
        score = '',
        status = '';

  Map<String, dynamic> toJson() => _$GameApiModelToJson(this);

  factory GameApiModel.fromJson(Map<String, dynamic> json) =>
      _$GameApiModelFromJson(json);

  GameEntity toEntity() => GameEntity(
        fixtureId: fixtureId,
        homeTeamLogo: homeTeamLogo,
        homeTeam: homeTeam,
        awayTeamLogo: awayTeamLogo,
        awayTeam: awayTeam,
        score: score,
        status: status,
      );

  // Convert Entity to API Object
  GameApiModel fromEntity(GameEntity entity) => GameApiModel(
        fixtureId: entity.fixtureId,
        homeTeamLogo: entity.homeTeamLogo,
        homeTeam: entity.homeTeam,
        awayTeamLogo: entity.awayTeamLogo,
        awayTeam: entity.awayTeam,
        score: entity.score,
        status: entity.status,
      );

  // Convert API List to Entity List
  List<GameEntity> toEntityList(List<GameApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        fixtureId,
        homeTeamLogo,
        homeTeam,
        awayTeamLogo,
        awayTeam,
        score,
        status
      ];
}
