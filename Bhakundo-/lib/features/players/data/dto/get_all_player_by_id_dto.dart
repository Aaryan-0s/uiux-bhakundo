import 'package:json_annotation/json_annotation.dart';
import 'package:nba_hub/features/players/data/model/player_api_model.dart';

part 'get_all_player_by_id_dto.g.dart';

@JsonSerializable()
class GetAllPlayerByIdDTO {
  final List<PlayerApiModel> data;

  GetAllPlayerByIdDTO({
    required this.data,
  });

  factory GetAllPlayerByIdDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllPlayerByIdDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllPlayerByIdDTOToJson(this);
}
