import 'package:json_annotation/json_annotation.dart';

import '../model/fixture_api_model.dart';

part 'get_fixture_by_id_dto.g.dart';

@JsonSerializable()
class GetFixtureByIdDTO {
  final List<FixtureApiModel> data;

  GetFixtureByIdDTO({
    required this.data,
  });

  factory GetFixtureByIdDTO.fromJson(Map<String, dynamic> json) =>
      _$GetFixtureByIdDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetFixtureByIdDTOToJson(this);
}
