import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nba_hub/features/profile/data/data_source/profile_local_data_source.dart';

import '../../../../core/common/provider/internet_connectivity.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/entity/profile_entity.dart';
import '../../domain/repository/profile_repository.dart';
import '../data_source/profile_remote_data_source.dart';

final profileRemoteRepoProvider = Provider<IProfileRepository>(
  (ref) => ProfileRemoteRepositoryImpl(
    profileRemoteDataSource: ref.read(profileRemoteDataSourceProvider),
    profileLocalDataSource: ref.read(profileLocalDataSourceProvider),
  ),
);

class ProfileRemoteRepositoryImpl implements IProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  final ProfileLocalDataSource profileLocalDataSource;

  ProfileRemoteRepositoryImpl(
      {required this.profileRemoteDataSource,
      required this.profileLocalDataSource});

  @override
  Future<Either<Failure, List<ProfileEntity>>> getProfile() async {
    final a = await checkConnectivity();

    if (a) {
      return profileRemoteDataSource.getProfile();
    } else {
      return profileLocalDataSource.getProfile();
    }
  }

  @override
  Future<Either<Failure, bool>> updateProfile(ProfileEntity profile) {
    return profileRemoteDataSource.updateProfile(profile);
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    return profileRemoteDataSource.uploadProfilePicture(file);
  }

  @override
  Future<Either<Failure, bool>> deleteProfile() {
    // TODO: implement deletePicture
    return profileRemoteDataSource.deleteProfile();
  }
}
