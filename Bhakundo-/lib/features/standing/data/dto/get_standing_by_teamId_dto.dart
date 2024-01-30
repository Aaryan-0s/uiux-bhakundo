import 'package:json_annotation/json_annotation.dart';

import '../model/standing_api_model.dart';

part 'get_standing_by_teamId_dto.g.dart';

@JsonSerializable()
class GetStandingByTeamIdDTO {
  final List<StandingApiModel> data;

  GetStandingByTeamIdDTO({
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetStandingByTeamIdDTOToJson(this);

  factory GetStandingByTeamIdDTO.fromJson(Map<String, dynamic> json) =>
      _$GetStandingByTeamIdDTOFromJson(json);
}
