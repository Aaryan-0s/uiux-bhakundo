import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String id;
  final String content;
  final UserId userId;
  final String gameId;
  final List<String> likes;
  final int likeCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CommentEntity({
    required this.id,
    required this.content,
    required this.userId,
    required this.gameId,
    required this.likes,
    required this.likeCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CommentEntity.fromJson(Map<String, dynamic> json) => CommentEntity(
        id: json["_id"],
        content: json["content"],
        userId: UserId.fromJson(json["userId"]),
        gameId: json["gameId"],
        likes: List<String>.from(json["likes"].map((x) => x)),
        likeCount: json["likeCount"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "content": content,
        "userId": userId.toJson(),
        "gameId": gameId,
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "likeCount": likeCount,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, content, userId, gameId, likes, likeCount, createdAt, updatedAt];

  @override
  String toString() {
    return 'CommentEntity(id: $id, content: $content, userId: $userId, gameId: $gameId, likes: $likes, likeCount: $likeCount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

class UserId {
  final String id;
  final String username;
  final String image;

  UserId({
    required this.id,
    required this.username,
    required this.image,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        username: json["username"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "image": image,
      };
}
