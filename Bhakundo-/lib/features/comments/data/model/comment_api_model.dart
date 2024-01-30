import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/comment_entity.dart';

part 'comment_api_model.g.dart';

final commentApiModelProvider = Provider<CommentApiModel>(
  (ref) => CommentApiModel.empty(),
);

@JsonSerializable()
class CommentApiModel extends Equatable {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'content')
  final String content;
  @JsonKey(name: 'userId')
  final UserId userId;
  @JsonKey(name: 'gameId')
  final String gameId;
  @JsonKey(name: 'likes')
  final List<String> likes;
  @JsonKey(name: 'likeCount')
  final int likeCount;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;

  const CommentApiModel({
    required this.id,
    required this.content,
    required this.userId,
    required this.gameId,
    required this.likes,
    required this.likeCount,
    required this.createdAt,
    required this.updatedAt,
  });

  CommentApiModel.empty()
      : id = '',
        content = '',
        userId = UserId(id: '', username: '', image: ''),
        gameId = '',
        likes = [],
        likeCount = 0,
        createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  CommentEntity toEntity() => CommentEntity(
        id: id,
        content: content,
        userId: userId,
        gameId: gameId,
        likes: likes,
        likeCount: likeCount,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  factory CommentApiModel.fromJson(Map<String, dynamic> json) =>
      _$CommentApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentApiModelToJson(this);
  CommentApiModel fromEntity(CommentEntity entity) => CommentApiModel(
        id: entity.id,
        content: entity.content,
        userId: entity.userId,
        gameId: entity.gameId,
        likes: entity.likes,
        likeCount: entity.likeCount,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );

  List<CommentEntity> toEntityList(List<CommentApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        content,
        userId,
        gameId,
        likes,
        likeCount,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() {
    return 'CommentApiModel{id: $id, content: $content, userId: $userId, gameId: $gameId, likes: $likes, likeCount: $likeCount, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
