import 'package:json_annotation/json_annotation.dart';

import '../model/profile_api_model.dart';

part 'get_profile_dto.g.dart';

@JsonSerializable()
class GetProfileDTO {
  final List<ProfileApiModel> data;

  GetProfileDTO({
    required this.data,
  });

  factory GetProfileDTO.fromJson(Map<String, dynamic> json) =>
      _$GetProfileDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetProfileDTOToJson(this);
}
