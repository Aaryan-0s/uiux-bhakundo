// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_comment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCommentDTO _$GetCommentDTOFromJson(Map<String, dynamic> json) =>
    GetCommentDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => CommentApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCommentDTOToJson(GetCommentDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
