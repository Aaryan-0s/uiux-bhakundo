import 'package:json_annotation/json_annotation.dart';

import '../model/favourite_player_api_model.dart';

part 'add_favourite_player_dto.g.dart';

@JsonSerializable()
class AddFavouritePlayerDTO {
  final List<FavouritePlayerApiModel> data;

  AddFavouritePlayerDTO({
    required this.data,
  });

  factory AddFavouritePlayerDTO.fromJson(Map<String, dynamic> json) =>
      _$AddFavouritePlayerDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AddFavouritePlayerDTOToJson(this);
}
