import 'package:json_annotation/json_annotation.dart';
import 'package:nba_hub/features/players/data/model/player_api_model.dart';

part 'get_all_player_dto.g.dart';

@JsonSerializable()
class GetAllPlayerDTO {
  final List<PlayerApiModel> data;

  GetAllPlayerDTO({
    required this.data,
  });

  factory GetAllPlayerDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllPlayerDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllPlayerDTOToJson(this);
}
