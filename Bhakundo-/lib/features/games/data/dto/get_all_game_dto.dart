import 'package:json_annotation/json_annotation.dart';

import '../model/game_api_model.dart';

part 'get_all_game_dto.g.dart';

@JsonSerializable()
class GetAllGameDTO {
  final List<GameApiModel> data;

  GetAllGameDTO({
    required this.data,
  });

  factory GetAllGameDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllGameDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllGameDTOToJson(this);
}
