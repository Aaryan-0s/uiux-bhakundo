import 'package:equatable/equatable.dart';

class FixtureInfoEntity extends Equatable {
  final int fixtureId;
  final String status;
  final String homeTeam;
  final String homeTeamLogo;
  final String awayTeam;
  final String awayTeamLogo;
  final String score;

  const FixtureInfoEntity({
    required this.fixtureId,
    required this.status,
    required this.homeTeam,
    required this.homeTeamLogo,
    required this.awayTeam,
    required this.awayTeamLogo,
    required this.score,
  });

  factory FixtureInfoEntity.fromJson(Map<String, dynamic> json) =>
      FixtureInfoEntity(
        fixtureId: json["fixtureId"],
        status: json["status"],
        homeTeam: json["homeTeam"],
        homeTeamLogo: json["homeTeamLogo"],
        awayTeam: json["awayTeam"],
        awayTeamLogo: json["awayTeamLogo"],
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "fixtureId": fixtureId,
        "status": status,
        "homeTeam": homeTeam,
        "homeTeamLogo": homeTeamLogo,
        "awayTeam": awayTeam,
        "awayTeamLogo": awayTeamLogo,
        "score": score,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        fixtureId,
        status,
        homeTeam,
        homeTeamLogo,
        awayTeam,
        awayTeamLogo,
        score,
      ];

  @override
  String toString() {
    return 'FixtureInfoEntity{fixtureId: $fixtureId, status: $status, homeTeam: $homeTeam, homeTeamLogo: $homeTeamLogo, awayTeam: $awayTeam, awayTeamLogo: $awayTeamLogo, score: $score}';
  }
}
