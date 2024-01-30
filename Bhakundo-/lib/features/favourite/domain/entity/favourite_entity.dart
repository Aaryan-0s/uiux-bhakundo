import 'package:equatable/equatable.dart';

class FavouriteEntity extends Equatable {
  final String? id;
  final String? userId;
  final String teamId;
  final String teamName;
  final String logoUrl;

  const FavouriteEntity({
    this.id,
    this.userId,
    required this.teamId,
    required this.teamName,
    required this.logoUrl,
  });

  factory FavouriteEntity.fromJson(Map<String, dynamic> json) =>
      FavouriteEntity(
        id: json["_id"],
        userId: json["userId"],
        teamId: json["teamId"],
        teamName: json["teamName"],
        logoUrl: json["logoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "teamId": teamId,
        "teamName": teamName,
        "logoUrl": logoUrl,
      };

  @override
  List<Object?> get props => [id, userId, teamId, teamName, logoUrl];

  @override
  String toString() {
    return 'FavouriteEntity {id: $id, userId: $userId, teamId: $teamId, teamName: $teamName, logoUrl: $logoUrl}';
  }
}
