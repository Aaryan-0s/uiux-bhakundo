import 'package:json_annotation/json_annotation.dart';
import 'package:nba_hub/features/fixture/data/model/fixture_info_api_model.dart';

part 'get_fixture_info_dto.g.dart';

@JsonSerializable()
class GetFixtureInfoDTO {
  final List<FixtureInfoApiModel> data;

  GetFixtureInfoDTO({
    required this.data,
  });

  factory GetFixtureInfoDTO.fromJson(Map<String, dynamic> json) =>
      _$GetFixtureInfoDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetFixtureInfoDTOToJson(this);
}
