import 'package:json_annotation/json_annotation.dart';
import 'package:nba_hub/features/Team/data/model/team_api_model.dart';

part 'get_all_team_dto.g.dart';

@JsonSerializable()
class GetAllTeamDTO {
  final List<TeamApiModel> data;

  GetAllTeamDTO({
    required this.data,
  });

  factory GetAllTeamDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllTeamDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllTeamDTOToJson(this);
}
