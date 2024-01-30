import 'package:equatable/equatable.dart';

class GameEntity extends Equatable {
  final int fixtureId;
  final String homeTeamLogo;
  final String homeTeam;
  final String awayTeamLogo;
  final String awayTeam;
  final String score;
  final String status;

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

  const GameEntity({
    required this.fixtureId,
    required this.homeTeamLogo,
    required this.homeTeam,
    required this.awayTeamLogo,
    required this.awayTeam,
    required this.score,
    required this.status,
  });

  factory GameEntity.fromJson(Map<String, dynamic> json) => GameEntity(
        fixtureId: json["fixtureId"],
        homeTeamLogo: json["homeTeamLogo"],
        homeTeam: json["homeTeam"],
        awayTeamLogo: json["awayTeamLogo"],
        awayTeam: json["awayTeam"],
        score: json["score"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "fixtureId": fixtureId,
        "homeTeamLogo": homeTeamLogo,
        "homeTeam": homeTeam,
        "awayTeamLogo": awayTeamLogo,
        "awayTeam": awayTeam,
        "score": score,
        "status": status,
      };

  @override
  String toString() {
    return 'GameEntity(fixtureId: $fixtureId, homeTeamLogo: $homeTeamLogo, homeTeam: $homeTeam, awayTeamLogo: $awayTeamLogo, awayTeam: $awayTeam, score: $score, status: $status)';
  }
}
