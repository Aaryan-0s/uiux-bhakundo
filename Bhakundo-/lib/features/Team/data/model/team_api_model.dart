import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/team_entity.dart';

part 'team_api_model.g.dart';

final teamApiModelProvider = Provider<TeamApiModel>(
  (ref) => TeamApiModel.empty(),
);

@JsonSerializable()
class TeamApiModel extends Equatable {
  @JsonKey(name: 'for')
  final ForAgainst datumFor;
  @JsonKey(name: 'against')
  final ForAgainst against;

  const TeamApiModel({
    required this.datumFor,
    required this.against,
  });

  TeamApiModel.empty()
      : datumFor = ForAgainst(
          total: Total(
            home: 0,
            away: 0,
            total: 0,
          ),
          average: Average(
            home: '0',
            away: '0',
            total: '0',
          ),
          minute: const {},
        ),
        against = ForAgainst(
          total: Total(
            home: 0,
            away: 0,
            total: 0,
          ),
          average: Average(
            home: '0',
            away: '0',
            total: '0',
          ),
          minute: const {},
        );

  factory TeamApiModel.fromJson(Map<String, dynamic> json) =>
      _$TeamApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamApiModelToJson(this);

  TeamEntity toEntity() => TeamEntity(
        datumFor: datumFor,
        against: against,
      );
  TeamApiModel fromEntity(TeamEntity entity) => TeamApiModel(
        datumFor: entity.datumFor,
        against: entity.against,
      );

  List<TeamEntity> toEntityList(List<TeamApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [datumFor, against];

  @override
  String toString() {
    return 'TeamApiModel(datumFor: $datumFor, against: $against)';
  }
}
