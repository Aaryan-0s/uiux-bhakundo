import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/fixture_entity.dart';

part 'fixture_api_model.g.dart';

final fixtureApiModelProvider =
    Provider<FixtureApiModel>((ref) => const FixtureApiModel.empty());

@JsonSerializable()
class FixtureApiModel extends Equatable {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'shotsOnGoal')
  final int shotsOnGoal;
  @JsonKey(name: 'shotsOffGoal')
  final int shotsOffGoal;
  @JsonKey(name: 'totalShots')
  final int totalShots;
  @JsonKey(name: 'blockedShots')
  final int blockedShots;
  @JsonKey(name: 'shotsInsideBox')
  final int shotsInsideBox;
  @JsonKey(name: 'shotsOutsideBox')
  final int shotsOutsideBox;
  @JsonKey(name: 'fouls')
  final int fouls;
  @JsonKey(name: 'cornerKicks')
  final int cornerKicks;
  @JsonKey(name: 'offsides')
  final int offsides;
  @JsonKey(name: 'ballPossession')
  final String ballPossession;

  const FixtureApiModel({
    required this.name,
    required this.shotsOnGoal,
    required this.shotsOffGoal,
    required this.totalShots,
    required this.blockedShots,
    required this.shotsInsideBox,
    required this.shotsOutsideBox,
    required this.fouls,
    required this.cornerKicks,
    required this.offsides,
    required this.ballPossession,
  });

  const FixtureApiModel.empty()
      : name = '',
        shotsOnGoal = 0,
        shotsOffGoal = 0,
        totalShots = 0,
        blockedShots = 0,
        shotsInsideBox = 0,
        shotsOutsideBox = 0,
        fouls = 0,
        cornerKicks = 0,
        offsides = 0,
        ballPossession = '';

  Map<String, dynamic> toJson() => _$FixtureApiModelToJson(this);

  factory FixtureApiModel.fromJson(Map<String, dynamic> json) =>
      _$FixtureApiModelFromJson(json);

  FixtureEntity toEntity() => FixtureEntity(
        name: name,
        shotsOnGoal: shotsOnGoal,
        shotsOffGoal: shotsOffGoal,
        totalShots: totalShots,
        blockedShots: blockedShots,
        shotsInsideBox: shotsInsideBox,
        shotsOutsideBox: shotsOutsideBox,
        fouls: fouls,
        cornerKicks: cornerKicks,
        offsides: offsides,
        ballPossession: ballPossession,
      );

  FixtureApiModel fromEntity(FixtureEntity entity) => FixtureApiModel(
        name: entity.name,
        shotsOnGoal: entity.shotsOnGoal,
        shotsOffGoal: entity.shotsOffGoal,
        totalShots: entity.totalShots,
        blockedShots: entity.blockedShots,
        shotsInsideBox: entity.shotsInsideBox,
        shotsOutsideBox: entity.shotsOutsideBox,
        fouls: entity.fouls,
        cornerKicks: entity.cornerKicks,
        offsides: entity.offsides,
        ballPossession: entity.ballPossession,
      );

  List<FixtureEntity> toEntityList(List<FixtureApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        name,
        shotsOnGoal,
        shotsOffGoal,
        totalShots,
        blockedShots,
        shotsInsideBox,
        shotsOutsideBox,
        fouls,
        cornerKicks,
        offsides,
        ballPossession
      ];
}
