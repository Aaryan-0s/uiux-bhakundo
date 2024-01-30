import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nba_hub/features/profile/domain/entity/profile_entity.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/repository/profile_repository.dart';
import '../data_source/profile_local_data_source.dart';

final profileLocalRepoProvider = Provider<IProfileRepository>((ref) {
  return ProfileLocalRepositoryImpl(
    profileLocalDataSource: ref.read(profileLocalDataSourceProvider),
  );
});

class ProfileLocalRepositoryImpl implements IProfileRepository {
  final ProfileLocalDataSource profileLocalDataSource;

  ProfileLocalRepositoryImpl({
    required this.profileLocalDataSource,
  });

  @override
  Future<Either<Failure, List<ProfileEntity>>> getProfile() {
    // TODO: implement getProfile
    return profileLocalDataSource.getProfile();
  }

  @override
  Future<Either<Failure, bool>> updateProfile(ProfileEntity profile) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> deleteProfile() {
    // TODO: implement deletePicture
    throw UnimplementedError();
  }
}
