import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/standing_player_entity.dart';

part 'standing_player_api_model.g.dart';

final standingPlayerApiModelProvider = Provider<StandingPlayerApiModel>(
  (ref) => const StandingPlayerApiModel.empty(),
);

@JsonSerializable()
class StandingPlayerApiModel extends Equatable {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'team')
  final String? team;
  @JsonKey(name: 'teamPicture')
  final String? teamPicture;
  @JsonKey(name: 'goals')
  final int? goals;
  @JsonKey(name: 'passes')
  final int? passes;
  @JsonKey(name: 'games')
  final int? games;
  @JsonKey(name: 'picture')
  final String? picture;

  const StandingPlayerApiModel({
    required this.id,
    required this.name,
    required this.team,
    required this.teamPicture,
    required this.goals,
    required this.passes,
    required this.games,
    required this.picture,
  });

  const StandingPlayerApiModel.empty()
      : id = 0,
        name = '',
        team = '',
        teamPicture = '',
        goals = 0,
        passes = 0,
        games = 0,
        picture = '';

  factory StandingPlayerApiModel.fromJson(Map<String, dynamic> json) =>
      _$StandingPlayerApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$StandingPlayerApiModelToJson(this);

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

  StandingPlayerApiModel fromEntity(StandingPlayerEntity entity) =>
      StandingPlayerApiModel(
        id: entity.id,
        name: entity.name,
        team: entity.team,
        teamPicture: entity.teamPicture,
        goals: entity.goals,
        passes: entity.passes,
        games: entity.games,
        picture: entity.picture,
      );

  List<StandingPlayerEntity> toEntityList(
          List<StandingPlayerApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        id,
        name,
        team,
        teamPicture,
        goals,
        passes,
        games,
        picture,
      ];
}
