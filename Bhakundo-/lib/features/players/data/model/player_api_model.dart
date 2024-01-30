import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/player_entity.dart';

part 'player_api_model.g.dart';

final playerApiModelProvider = Provider<PlayerApiModel>(
  (ref) => PlayerApiModel.empty(),
);

@JsonSerializable()
class PlayerApiModel extends Equatable {
  @JsonKey(name: 'player')
  final Player player;
  @JsonKey(name: 'statistics')
  final List<Statistic> statistics;

  const PlayerApiModel({
    required this.player,
    required this.statistics,
  });

  PlayerApiModel.empty()
      : player = Player(
          id: 0,
          name: '',
          firstname: '',
          lastname: '',
          age: 0,
          nationality: '',
          height: '',
          weight: '',
          injured: false,
          photo: '',
        ),
        statistics = [];
  factory PlayerApiModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerApiModelToJson(this);
  PlayerEntity toEntity() => PlayerEntity(
        player: player,
        statistics: statistics,
      );

  PlayerApiModel fromEntity(PlayerEntity entity) => PlayerApiModel(
        player: entity.player,
        statistics: entity.statistics,
      );

  List<PlayerEntity> toEntityList(List<PlayerApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  // TODO: implement props
  List<Object?> get props => [player, statistics];

  @override
  String toString() {
    return 'PlayerApiModel{player: $player, statistics: $statistics}';
  }
}
