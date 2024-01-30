import 'package:json_annotation/json_annotation.dart';

part 'fixture_model.g.dart';

@JsonSerializable()
class FixtureModel {
  @JsonKey(name: 'name')
  final String? name;
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

  FixtureModel({
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

  factory FixtureModel.fromJson(Map<String, dynamic> json) =>
      _$FixtureModelFromJson(json);
  Map<String, dynamic> toJson() => _$FixtureModelToJson(this);
}
