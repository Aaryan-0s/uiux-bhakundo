import 'package:json_annotation/json_annotation.dart';

import '../model/standing_player_api_model.dart';

part 'get_all_standing_player_dto.g.dart';

@JsonSerializable()
class GetAllStandingPlayerDTO {
  final List<StandingPlayerApiModel> data;

  GetAllStandingPlayerDTO({
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllStandingPlayerDTOToJson(this);

  factory GetAllStandingPlayerDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllStandingPlayerDTOFromJson(json);
}
