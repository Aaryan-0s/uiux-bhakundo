import 'package:json_annotation/json_annotation.dart';

import '../model/favourite_api_model.dart';

part 'add_favourite_dto.g.dart';

@JsonSerializable()
class AddFavouriteDTO {
  final List<FavouriteApiModel> data;

  AddFavouriteDTO({
    required this.data,
  });

  factory AddFavouriteDTO.fromJson(Map<String, dynamic> json) =>
      _$AddFavouriteDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AddFavouriteDTOToJson(this);
}
