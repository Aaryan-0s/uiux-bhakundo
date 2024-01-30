import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nba_hub/features/fixture/domain/entity/fixture_info_entity.dart';

part 'fixture_info_api_model.g.dart';

final fixtureInfoApiModelProvider =
    Provider<FixtureInfoApiModel>((ref) => const FixtureInfoApiModel.empty());

@JsonSerializable()
class FixtureInfoApiModel extends Equatable {
  @JsonKey(name: 'fixtureId')
  final int fixtureId;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'homeTeam')
  final String homeTeam;
  @JsonKey(name: 'homeTeamLogo')
  final String homeTeamLogo;
  @JsonKey(name: 'awayTeam')
  final String awayTeam;
  @JsonKey(name: 'awayTeamLogo')
  final String awayTeamLogo;
  @JsonKey(name: 'score')
  final String score;

  const FixtureInfoApiModel({
    required this.fixtureId,
    required this.status,
    required this.homeTeam,
    required this.homeTeamLogo,
    required this.awayTeam,
    required this.awayTeamLogo,
    required this.score,
  });

  const FixtureInfoApiModel.empty()
      : fixtureId = 0,
        status = '',
        homeTeam = '',
        homeTeamLogo = '',
        awayTeam = '',
        awayTeamLogo = '',
        score = '';

  FixtureInfoEntity toEntity() => FixtureInfoEntity(
      fixtureId: fixtureId,
      status: status,
      homeTeam: homeTeam,
      homeTeamLogo: homeTeamLogo,
      awayTeam: awayTeam,
      awayTeamLogo: awayTeamLogo,
      score: score);

  FixtureInfoApiModel fromEntity(FixtureInfoEntity entity) =>
      FixtureInfoApiModel(
        fixtureId: entity.fixtureId,
        status: entity.status,
        homeTeam: entity.homeTeam,
        homeTeamLogo: entity.homeTeamLogo,
        awayTeam: entity.awayTeam,
        awayTeamLogo: entity.awayTeamLogo,
        score: entity.score,
      );
  List<FixtureInfoEntity> toEntityList(List<FixtureInfoApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        fixtureId,
        status,
        homeTeam,
        homeTeamLogo,
        awayTeam,
        awayTeamLogo,
        score,
      ];

  factory FixtureInfoApiModel.fromJson(Map<String, dynamic> json) =>
      _$FixtureInfoApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$FixtureInfoApiModelToJson(this);
}
