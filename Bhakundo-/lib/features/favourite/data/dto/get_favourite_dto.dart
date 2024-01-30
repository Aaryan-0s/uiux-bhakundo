import 'package:json_annotation/json_annotation.dart';

import '../model/favourite_api_model.dart';

part 'get_favourite_dto.g.dart';

@JsonSerializable()
class GetFavouriteDTO {
  final List<FavouriteApiModel> data;

  GetFavouriteDTO({
    required this.data,
  });

  factory GetFavouriteDTO.fromJson(Map<String, dynamic> json) =>
      _$GetFavouriteDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetFavouriteDTOToJson(this);
}
