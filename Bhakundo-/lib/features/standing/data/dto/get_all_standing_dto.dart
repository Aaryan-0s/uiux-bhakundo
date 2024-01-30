import 'package:json_annotation/json_annotation.dart';

import '../model/standing_api_model.dart';

part 'get_all_standing_dto.g.dart';

@JsonSerializable()
class GetAllStandingDTO {
  final List<StandingApiModel> data;

  GetAllStandingDTO({
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllStandingDTOToJson(this);

  factory GetAllStandingDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllStandingDTOFromJson(json);
}
