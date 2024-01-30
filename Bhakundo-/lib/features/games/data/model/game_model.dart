import 'package:json_annotation/json_annotation.dart';

part 'game_model.g.dart';

@JsonSerializable()
class MatchModel {
  @JsonKey(name: 'fixtureId')
  final int? fixtureId;
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

  MatchModel({
    required this.fixtureId,
    required this.homeTeamLogo,
    required this.homeTeam,
    required this.awayTeamLogo,
    required this.awayTeam,
    required this.score,
    required this.status,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) =>
      _$MatchModelFromJson(json);
  Map<String, dynamic> toJson() => _$MatchModelToJson(this);
}
