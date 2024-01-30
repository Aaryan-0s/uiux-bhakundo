import 'package:json_annotation/json_annotation.dart';

import '../model/favourite_player_api_model.dart';

part 'get_favourite_player_dto.g.dart';

@JsonSerializable()
class GetFavouritePlayerDTO {
  final List<FavouritePlayerApiModel> data;

  GetFavouritePlayerDTO({
    required this.data,
  });
  factory GetFavouritePlayerDTO.fromJson(Map<String, dynamic> json) =>
      _$GetFavouritePlayerDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetFavouritePlayerDTOToJson(this);
}
