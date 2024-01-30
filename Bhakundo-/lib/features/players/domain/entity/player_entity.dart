import 'package:equatable/equatable.dart';

class PlayerEntity extends Equatable {
  final Player player;
  final List<Statistic> statistics;

  const PlayerEntity({
    required this.player,
    required this.statistics,
  });

  factory PlayerEntity.fromJson(Map<String, dynamic> json) => PlayerEntity(
        player: Player.fromJson(json["player"]),
        statistics: List<Statistic>.from(
            json["statistics"].map((x) => Statistic.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "player": player.toJson(),
        "statistics": List<dynamic>.from(statistics.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [
        player,
        statistics,
      ];

  @override
  String toString() {
    return 'PlayerEntity(player: $player, statistics: $statistics)';
  }
}

class Player {
  final int id;
  final String name;
  final String firstname;
  final String lastname;
  final int age;
  final String nationality;
  final String height;
  final String weight;
  final bool injured;
  final String photo;

  Player({
    required this.id,
    required this.name,
    required this.firstname,
    required this.lastname,
    required this.age,
    required this.nationality,
    required this.height,
    required this.weight,
    required this.injured,
    required this.photo,
  });

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json["id"],
        name: json["name"] ?? '',
        firstname: json["firstname"] ?? '',
        lastname: json["lastname"] ?? '',
        age: json["age"] ?? 0,
        nationality: json["nationality"] ?? '',
        height: json["height"] ?? '',
        weight: json["weight"] ?? '',
        injured: json["injured"] ?? false,
        photo: json["photo"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "firstname": firstname,
        "lastname": lastname,
        "age": age,
        "nationality": nationality,
        "height": height,
        "weight": weight,
        "injured": injured,
        "photo": photo,
      };
}

class Statistic {
  final Team team;
  final League league;
  final Games games;
  final Substitutes substitutes;
  final Shots shots;
  final Goals goals;
  final Passes passes;
  final Tackles tackles;
  final Duels duels;
  final Dribbles dribbles;
  final Fouls fouls;
  final Cards cards;
  final Penalty penalty;

  Statistic({
    required this.team,
    required this.league,
    required this.games,
    required this.substitutes,
    required this.shots,
    required this.goals,
    required this.passes,
    required this.tackles,
    required this.duels,
    required this.dribbles,
    required this.fouls,
    required this.cards,
    required this.penalty,
  });

  factory Statistic.fromJson(Map<String, dynamic> json) => Statistic(
        team: Team.fromJson(json["team"]),
        league: League.fromJson(json["league"]),
        games: Games.fromJson(json["games"]),
        substitutes: Substitutes.fromJson(json["substitutes"]),
        shots: Shots.fromJson(json["shots"]),
        goals: Goals.fromJson(json["goals"]),
        passes: Passes.fromJson(json["passes"]),
        tackles: Tackles.fromJson(json["tackles"]),
        duels: Duels.fromJson(json["duels"]),
        dribbles: Dribbles.fromJson(json["dribbles"]),
        fouls: Fouls.fromJson(json["fouls"]),
        cards: Cards.fromJson(json["cards"]),
        penalty: Penalty.fromJson(json["penalty"]),
      );

  Map<String, dynamic> toJson() => {
        "team": team.toJson(),
        "league": league.toJson(),
        "games": games.toJson(),
        "substitutes": substitutes.toJson(),
        "shots": shots.toJson(),
        "goals": goals.toJson(),
        "passes": passes.toJson(),
        "tackles": tackles.toJson(),
        "duels": duels.toJson(),
        "dribbles": dribbles.toJson(),
        "fouls": fouls.toJson(),
        "cards": cards.toJson(),
        "penalty": penalty.toJson(),
      };
}

class Cards {
  final int yellow;
  final int yellowred;
  final int red;

  Cards({
    required this.yellow,
    required this.yellowred,
    required this.red,
  });

  factory Cards.fromJson(Map<String, dynamic> json) => Cards(
        yellow: json["yellow"] ?? 0,
        yellowred: json["yellowred"] ?? 0,
        red: json["red"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "yellow": yellow,
        "yellowred": yellowred,
        "red": red,
      };
}

class Dribbles {
  final dynamic attempts;
  final dynamic success;
  final dynamic past;

  Dribbles({
    this.attempts,
    this.success,
    this.past,
  });

  factory Dribbles.fromJson(Map<String, dynamic> json) => Dribbles(
        attempts: json["attempts"],
        success: json["success"],
        past: json["past"],
      );

  Map<String, dynamic> toJson() => {
        "attempts": attempts,
        "success": success,
        "past": past,
      };
}

class Duels {
  final dynamic total;
  final dynamic won;

  Duels({
    this.total,
    this.won,
  });

  factory Duels.fromJson(Map<String, dynamic> json) => Duels(
        total: json["total"],
        won: json["won"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "won": won,
      };
}

class Fouls {
  final dynamic drawn;
  final dynamic committed;

  Fouls({
    this.drawn,
    this.committed,
  });

  factory Fouls.fromJson(Map<String, dynamic> json) => Fouls(
        drawn: json["drawn"],
        committed: json["committed"],
      );

  Map<String, dynamic> toJson() => {
        "drawn": drawn,
        "committed": committed,
      };
}

class Games {
  final int appearences;
  final int lineups;
  final int minutes;
  final dynamic number;
  final String position;
  final dynamic rating;
  final bool captain;

  Games({
    required this.appearences,
    required this.lineups,
    required this.minutes,
    this.number,
    required this.position,
    this.rating,
    required this.captain,
  });

  factory Games.fromJson(Map<String, dynamic> json) => Games(
        appearences: json["appearences"] ?? 0,
        lineups: json["lineups"] ?? 0,
        minutes: json["minutes"] ?? 0,
        number: json["number"],
        position: json["position"] ?? '',
        rating: json["rating"],
        captain: json["captain"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "appearences": appearences,
        "lineups": lineups,
        "minutes": minutes,
        "number": number,
        "position": position,
        "rating": rating,
        "captain": captain,
      };
}

class Goals {
  final int total;
  final dynamic conceded;
  final dynamic assists;
  final dynamic saves;

  Goals({
    required this.total,
    this.conceded,
    this.assists,
    this.saves,
  });

  factory Goals.fromJson(Map<String, dynamic> json) => Goals(
        total: json["total"] ?? 0,
        conceded: json["conceded"],
        assists: json["assists"],
        saves: json["saves"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "conceded": conceded,
        "assists": assists,
        "saves": saves,
      };
}

class League {
  final int id;
  final String name;
  final String country;
  final String logo;
  final String flag;
  final int season;

  League({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
    required this.flag,
    required this.season,
  });

  factory League.fromJson(Map<String, dynamic> json) => League(
        id: json["id"],
        name: json["name"] ?? '',
        country: json["country"] ?? '',
        logo: json["logo"] ?? '',
        flag: json["flag"] ?? '',
        season: json["season"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country,
        "logo": logo,
        "flag": flag,
        "season": season,
      };
}

class Passes {
  final dynamic total;
  final dynamic key;
  final dynamic accuracy;

  Passes({
    this.total,
    this.key,
    this.accuracy,
  });

  factory Passes.fromJson(Map<String, dynamic> json) => Passes(
        total: json["total"],
        key: json["key"],
        accuracy: json["accuracy"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "key": key,
        "accuracy": accuracy,
      };
}

class Penalty {
  final dynamic won;
  final dynamic commited;
  final dynamic scored;
  final dynamic missed;
  final dynamic saved;

  Penalty({
    this.won,
    this.commited,
    this.scored,
    this.missed,
    this.saved,
  });

  factory Penalty.fromJson(Map<String, dynamic> json) => Penalty(
        won: json["won"],
        commited: json["commited"],
        scored: json["scored"],
        missed: json["missed"],
        saved: json["saved"],
      );

  Map<String, dynamic> toJson() => {
        "won": won,
        "commited": commited,
        "scored": scored,
        "missed": missed,
        "saved": saved,
      };
}

class Shots {
  final dynamic total;
  final dynamic on;

  Shots({
    this.total,
    this.on,
  });

  factory Shots.fromJson(Map<String, dynamic> json) => Shots(
        total: json["total"],
        on: json["on"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "on": on,
      };
}

class Substitutes {
  final int substitutesIn;
  final int out;
  final int bench;

  Substitutes({
    required this.substitutesIn,
    required this.out,
    required this.bench,
  });

  factory Substitutes.fromJson(Map<String, dynamic> json) => Substitutes(
        substitutesIn: json["in"] ?? 0,
        out: json["out"] ?? 0,
        bench: json["bench"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "in": substitutesIn,
        "out": out,
        "bench": bench,
      };
}

class Tackles {
  final dynamic total;
  final dynamic blocks;
  final dynamic interceptions;

  Tackles({
    this.total,
    this.blocks,
    this.interceptions,
  });

  factory Tackles.fromJson(Map<String, dynamic> json) => Tackles(
        total: json["total"],
        blocks: json["blocks"],
        interceptions: json["interceptions"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "blocks": blocks,
        "interceptions": interceptions,
      };
}

class Team {
  final int id;
  final String name;
  final String logo;

  Team({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        name: json["name"] ?? '',
        logo: json["logo"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
      };
}
