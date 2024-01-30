import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/profile_entity.dart';

part 'profile_api_model.g.dart';

final profileApiModelProvider = Provider<ProfileApiModel>((ref) {
  return const ProfileApiModel.empty();
});

@JsonSerializable()
class ProfileApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? userId;
  @JsonKey(name: 'fname')
  final String fname;
  @JsonKey(name: 'lname')
  final String lname;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'image')
  final String? image;

  const ProfileApiModel({
    this.userId,
    required this.fname,
    required this.lname,
    required this.image,
    required this.username,
    required this.email,
  });
  const ProfileApiModel.empty()
      : userId = '',
        fname = '',
        lname = '',
        image = '',
        email = '',
        username = '';
  // convert ProfileApiModel to ProfileEntity
  ProfileEntity toEntity() => ProfileEntity(
        userId: userId,
        fname: fname,
        lname: lname,
        image: image,
        email: email,
        username: username,
      );

  ProfileApiModel fromEntity(ProfileEntity entity) => ProfileApiModel(
        userId: userId,
        username: username,
        fname: fname,
        lname: lname,
        email: email,
        image: image,
        // exchangedRequest: exchangedRequest,
        // bookmarkedBooks: bookmarkedBooks,
      );

  Map<String, dynamic> toJson() => _$ProfileApiModelToJson(this);

  factory ProfileApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileApiModelFromJson(json);

  // Convert ProfileApiModel list to ProfileEntity list
  List<ProfileEntity> toEntityList(List<ProfileApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'ProfileApiModel( id: $userId, fname: $fname, lname: $lname, image: $image,username: $username)';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [userId, fname, lname, image, email, username];
}
