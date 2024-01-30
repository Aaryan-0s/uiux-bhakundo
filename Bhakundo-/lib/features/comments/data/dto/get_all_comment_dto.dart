import 'package:json_annotation/json_annotation.dart';
import 'package:nba_hub/features/comments/data/model/comment_api_model.dart';

part 'get_all_comment_dto.g.dart';

@JsonSerializable()
class GetCommentDTO {
  final List<CommentApiModel> data;

  GetCommentDTO({
    required this.data,
  });

  factory GetCommentDTO.fromJson(Map<String, dynamic> json) =>
      _$GetCommentDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetCommentDTOToJson(this);
}
