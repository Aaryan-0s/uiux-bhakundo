import 'package:json_annotation/json_annotation.dart';

import '../model/game_api_model.dart';

part 'get_all_games_by_date_dto.g.dart';

@JsonSerializable()
class GetAllGameByDateDTO {
  final List<GameApiModel> data;

  GetAllGameByDateDTO({
    required this.data,
  });

  factory GetAllGameByDateDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllGameByDateDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllGameByDateDTOToJson(this);
}
