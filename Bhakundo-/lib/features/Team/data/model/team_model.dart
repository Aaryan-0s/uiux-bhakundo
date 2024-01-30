import 'package:json_annotation/json_annotation.dart';

part 'team_model.g.dart';

@JsonSerializable()
class TeamModel {
  @JsonKey(name: 'forTotal')
  final GoalTotalModel forTotal;
  @JsonKey(name: 'forAverage')
  final GoalAverageModel forAverage;
  @JsonKey(name: 'forMinute')
  final Map<String, GoalMinuteModel> forMinute;
  @JsonKey(name: 'againstTotal')
  final GoalTotalModel againstTotal;
  @JsonKey(name: 'againstAverage')
  final GoalAverageModel againstAverage;
  @JsonKey(name: 'againstMinute')
  final Map<String, GoalMinuteModel> againstMinute;

  TeamModel({
    required this.forTotal,
    required this.forAverage,
    required this.forMinute,
    required this.againstTotal,
    required this.againstAverage,
    required this.againstMinute,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) =>
      _$TeamModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamModelToJson(this);
}

@JsonSerializable()
class GoalTotalModel {
  @JsonKey(name: 'home')
  final int home;
  @JsonKey(name: 'away')
  final int away;
  @JsonKey(name: 'total')
  final int total;

  GoalTotalModel({
    required this.home,
    required this.away,
    required this.total,
  });

  factory GoalTotalModel.fromJson(Map<String, dynamic> json) =>
      _$GoalTotalModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoalTotalModelToJson(this);
}

@JsonSerializable()
class GoalAverageModel {
  @JsonKey(name: 'home')
  final double home;
  @JsonKey(name: 'away')
  final double away;
  @JsonKey(name: 'total')
  final double total;

  GoalAverageModel({
    required this.home,
    required this.away,
    required this.total,
  });

  factory GoalAverageModel.fromJson(Map<String, dynamic> json) =>
      _$GoalAverageModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoalAverageModelToJson(this);
}

@JsonSerializable()
class GoalMinuteModel {
  @JsonKey(name: 'total')
  final int total;
  @JsonKey(name: 'percentage')
  final String percentage;

  GoalMinuteModel({
    required this.total,
    required this.percentage,
  });

  factory GoalMinuteModel.fromJson(Map<String, dynamic> json) =>
      _$GoalMinuteModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoalMinuteModelToJson(this);
}
