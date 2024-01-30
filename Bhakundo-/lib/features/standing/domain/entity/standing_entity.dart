import 'package:equatable/equatable.dart';

class StandingEntity extends Equatable {
  final int rank;
  final int id;
  final String name;
  final String logo;
  final int points;
  final int goalsDiff;
  final String status;
  final int played;
  final int win;
  final int draw;
  final int lose;
  final int goalsFor;
  final int goalsAgainst;

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

  const StandingEntity({
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

  factory StandingEntity.fromJson(Map<String, dynamic> json) => StandingEntity(
        rank: json["rank"],
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        points: json["points"],
        goalsDiff: json["goalsDiff"],
        status: json["status"],
        played: json["played"],
        win: json["win"],
        draw: json["draw"],
        lose: json["lose"],
        goalsFor: json["goalsFor"],
        goalsAgainst: json["goalsAgainst"],
      );

  Map<String, dynamic> toJson() => {
        "rank": rank,
        "id": id,
        "name": name,
        "logo": logo,
        "points": points,
        "goalsDiff": goalsDiff,
        "status": status,
        "played": played,
        "win": win,
        "draw": draw,
        "lose": lose,
        "goalsFor": goalsFor,
        "goalsAgainst": goalsAgainst,
      };

  @override
  String toString() {
    return 'StandingEntity(rank: $rank, id: $id, name: $name, logo: $logo, points: $points, goalsDiff: $goalsDiff, status: $status,  played: $played, win: $win, draw: $draw, lose: $lose, goalsFor: $goalsFor, goalsAgainst: $goalsAgainst)';
  }
}
