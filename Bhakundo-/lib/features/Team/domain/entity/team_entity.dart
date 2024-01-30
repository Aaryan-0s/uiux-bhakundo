import 'package:equatable/equatable.dart';

class TeamEntity extends Equatable {
  final ForAgainst datumFor;
  final ForAgainst against;

  const TeamEntity({
    required this.datumFor,
    required this.against,
  });

  factory TeamEntity.fromJson(Map<String, dynamic> json) => TeamEntity(
        datumFor: ForAgainst.fromJson(json["for"]),
        against: ForAgainst.fromJson(json["against"]),
      );

  Map<String, dynamic> toJson() => {
        "for": datumFor.toJson(),
        "against": against.toJson(),
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        datumFor,
        against,
      ];
  @override
  String toString() {
    return 'TeamEntity(datumFor: $datumFor, against: $against)';
  }
}

class ForAgainst {
  final Total total;
  final Average average;
  final Map<String, Minute> minute;

  ForAgainst({
    required this.total,
    required this.average,
    required this.minute,
  });

  factory ForAgainst.fromJson(Map<String, dynamic> json) => ForAgainst(
        total: Total.fromJson(json["total"]),
        average: Average.fromJson(json["average"]),
        minute: Map.from(json["minute"])
            .map((k, v) => MapEntry<String, Minute>(k, Minute.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "total": total.toJson(),
        "average": average.toJson(),
        "minute": Map.from(minute)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Average {
  final String home;
  final String away;
  final String total;

  Average({
    required this.home,
    required this.away,
    required this.total,
  });

  factory Average.fromJson(Map<String, dynamic> json) => Average(
        home: json["home"],
        away: json["away"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "home": home,
        "away": away,
        "total": total,
      };
}

class Minute {
  final int total;
  final String percentage;

  Minute({
    required this.total,
    required this.percentage,
  });

  factory Minute.fromJson(Map<String, dynamic> json) => Minute(
        total: json["total"],
        percentage: json["percentage"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "percentage": percentage,
      };
}

class Total {
  final int home;
  final int away;
  final int total;

  Total({
    required this.home,
    required this.away,
    required this.total,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        home: json["home"],
        away: json["away"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "home": home,
        "away": away,
        "total": total,
      };
}
