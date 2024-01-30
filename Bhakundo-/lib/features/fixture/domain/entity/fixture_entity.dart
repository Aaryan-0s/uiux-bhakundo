import 'package:equatable/equatable.dart';

class FixtureEntity extends Equatable {
  final String name;
  final int shotsOnGoal;
  final int shotsOffGoal;
  final int totalShots;
  final int blockedShots;
  final int shotsInsideBox;
  final int shotsOutsideBox;
  final int fouls;
  final int cornerKicks;
  final int offsides;
  final String ballPossession;

  const FixtureEntity({
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
        ballPossession,
      ];

  factory FixtureEntity.fromJson(Map<String, dynamic> json) {
    return FixtureEntity(
      name: json["name"],
      shotsOnGoal: json["shotsOnGoal"],
      shotsOffGoal: json["shotsOffGoal"],
      totalShots: json["totalShots"],
      blockedShots: json["blockedShots"] ?? 0,
      shotsInsideBox: json["shotsInsideBox"],
      shotsOutsideBox: json["shotsOutsideBox"],
      fouls: json["fouls"],
      cornerKicks: json["cornerKicks"],
      offsides: json["offsides"],
      ballPossession: json["ballPossession"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "shotsOnGoal": shotsOnGoal,
      "shotsOffGoal": shotsOffGoal,
      "totalShots": totalShots,
      "blockedShots": blockedShots,
      "shotsInsideBox": shotsInsideBox,
      "shotsOutsideBox": shotsOutsideBox,
      "fouls": fouls,
      "cornerKicks": cornerKicks,
      "offsides": offsides,
      "ballPossession": ballPossession,
    };
  }

  @override
  String toString() {
    return 'FixtureEntity(name: $name, shotsOnGoal: $shotsOnGoal, shotsOffGoal: $shotsOffGoal, totalShots: $totalShots, blockedShots: $blockedShots, shotsInsideBox: $shotsInsideBox, shotsOutsideBox: $shotsOutsideBox, fouls: $fouls, cornerKicks: $cornerKicks, offsides: $offsides, ballPossession: $ballPossession)';
  }
}
