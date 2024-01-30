import 'package:equatable/equatable.dart';

class StandingPlayerEntity extends Equatable {
  final int id;
  final String name;

  final String team;
  final String teamPicture;
  final int goals;
  final int passes;
  final int games;
  final String picture;

  const StandingPlayerEntity({
    required this.id,
    required this.name,
    required this.team,
    required this.teamPicture,
    required this.goals,
    required this.passes,
    required this.games,
    required this.picture,
  });

  @override
  List<Object?> get props =>
      [id, name, team, teamPicture, goals, passes, games, picture];

  factory StandingPlayerEntity.fromJson(Map<String, dynamic> json) {
    return StandingPlayerEntity(
      id: json['id'],
      name: json['name'],
      team: json['team'],
      teamPicture: json['teamPicture'],
      goals: json['goals'],
      passes: json['passes'],
      games: json['games'],
      picture: json['picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'team': team,
      'teamPicture': teamPicture,
      'goals': goals,
      'passes': passes,
      'games': games,
      'picture': picture,
    };
  }

  @override
  String toString() {
    return 'StandingPlayerEntity("id":$id,name: $name, team: $team, teamPicture: $teamPicture, goals: $goals, passes: $passes, games: $games, picture: $picture)';
  }
}
