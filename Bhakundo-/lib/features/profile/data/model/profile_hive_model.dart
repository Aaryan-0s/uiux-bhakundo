import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nba_hub/features/profile/data/model/profile_api_model.dart';

import '../../../../config/constants/hive_table_constant.dart';
import '../../domain/entity/profile_entity.dart';

part 'profile_hive_model.g.dart';

final profileHiveModelProvider = Provider(
  (ref) => const ProfileHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.profileTableId)
class ProfileHiveModel {
  @HiveField(0)
  final String? userId;

  @HiveField(1)
  final String fname;

  @HiveField(2)
  final String lname;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String username;

  @HiveField(5)
  final String? image;

  // empty constructor
  const ProfileHiveModel.empty()
      : userId = '',
        fname = '',
        lname = '',
        image = '',
        email = '',
        username = '';

  ProfileHiveModel({
    required this.userId,
    required this.fname,
    required this.lname,
    required this.image,
    required this.username,
    required this.email,
  });

  // Convert Hive Object to Entity
  ProfileEntity toEntity() => ProfileEntity(
        userId: userId,
        fname: fname,
        lname: lname,
        image: image,
        email: email,
        username: username,
      );

  // Convert Entity to Hive Object
  ProfileHiveModel toHiveModel(ProfileEntity entity) => ProfileHiveModel(
        userId: userId,
        username: username,
        fname: fname,
        lname: lname,
        email: email,
        image: image,
        // exchangedRequest: exchangedRequest,
      );

  List<ProfileHiveModel> fromApiModelList(List<ProfileApiModel> apiModels) {
    return apiModels
        .map((apiModel) => ProfileHiveModel(
            userId: apiModel.userId,
            fname: apiModel.fname,
            lname: apiModel.lname,
            email: apiModel.email,
            username: apiModel.username,
            image: apiModel.image))
        .toList();
  }

  // Convert Hive List to Entity List
  List<ProfileEntity> toEntityList(List<ProfileHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'ProfileHiveModel( userId: $userId, fname: $fname, lname: $lname, email: $email, username: $username, image: $image)';
  }
}
