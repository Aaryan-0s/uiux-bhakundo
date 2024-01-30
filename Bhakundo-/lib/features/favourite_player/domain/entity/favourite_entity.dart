import 'package:equatable/equatable.dart';

class FavouritePlayerEntity extends Equatable {
  final String? id;
  final String? userId;
  final String playerId;
  final String playerName;
  final String photoUrl;

  const FavouritePlayerEntity({
    this.id,
    this.userId,
    required this.playerId,
    required this.playerName,
    required this.photoUrl,
  });

  factory FavouritePlayerEntity.fromJson(Map<String, dynamic> json) =>
      FavouritePlayerEntity(
        id: json["_id"],
        userId: json["userId"],
        playerId: json["playerId"],
        playerName: json["playerName"],
        photoUrl: json["photoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "playerId": playerId,
        "playerName": playerName,
        "photoUrl": photoUrl,
      };

  @override
  List<Object?> get props => [id, userId, playerId, playerName, photoUrl];

  @override
  String toString() {
    return 'FavouritePlayerEntity {id: $id, userId: $userId, playerId: $playerId, playerName: $playerName, photoUrl: $photoUrl}';
  }
}
